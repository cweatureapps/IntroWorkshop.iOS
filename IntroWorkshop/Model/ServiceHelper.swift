//
//  ServiceHelper.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 23/09/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation
import Alamofire

protocol ServiceHelper {
    typealias RequestCompletion = (Result<JSON, ServiceError>) -> Void

    /// Make a request to the backend.
    func request(urlString: String, param: String?, completion: @escaping RequestCompletion)
}

extension ServiceHelper {
    func adjustUrl(urlString: String, withParam param: String) -> String {
        let lastDotRange = urlString.range(of: ".", options: .backwards)
        return urlString.substring(to: lastDotRange!.lowerBound) + param + urlString.substring(from: lastDotRange!.lowerBound)
    }
}


/// Factory that returns the ServiceHelper to use.
class ServiceHelperFactory {
    static func makeServiceHelper() -> ServiceHelper  {
        // For now, we always return the stub version
        return StubServiceHelper()
    }
}

enum ServiceError: Error {
    case general
    case loadingFailed(String)
}

/// Service Helper class which makes a network request.
class NetworkServiceHelper: ServiceHelper {

    func request(urlString: String, param: String?, completion: @escaping ServiceHelper.RequestCompletion) {
        let adjustedUrlString = param == nil ? urlString : self.adjustUrl(urlString: urlString, withParam: param!)
        let headers = ["Content-Type": "application/json"]
        Alamofire.request(adjustedUrlString, encoding: JSONEncoding.default, headers: headers)
         .responseJSON { response in
            switch response.result {
            case .success(let value):
                 if let json = value as? JSON {
                    completion(.success(json))
                 } else {
                    completion(.failure(ServiceError.general))
                 }
            case .failure:
                completion(.failure(ServiceError.general))
            }
         }
    }
}

/// Service Helper which loads JSON stub response from a file.
class StubServiceHelper: ServiceHelper {

    private enum Constants {
        static let delay = 0.3
    }

    /// Loads a stub JSON file asynchronously from disk as if it were a backend response.
    /// Filename is based on convention, should be named the same as last part after the slash.
    func request(urlString: String, param: String?, completion: @escaping ServiceHelper.RequestCompletion) {

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Constants.delay) {
            do {
                let adjustedUrlString = param == nil ? urlString : self.adjustUrl(urlString: urlString, withParam: param!)
                let fileName = self.fileNameFrom(urlString: adjustedUrlString)
                let response = try self.loadJSONDictionary(from: fileName)
                completion(.success(response))
            } catch (let error) {
                let serviceError = ServiceError.loadingFailed(error.localizedDescription)
                completion(.failure(serviceError))
            }
        }
    }

    /// Loads a file from disk as a dictionary
    private func loadJSONDictionary(from filename: String) throws -> JSON {
        let splitFilename = filename.components(separatedBy: ".")
        if let filepath = Bundle(for: StubServiceHelper.self).path(forResource: splitFilename[0], ofType: splitFilename[1]),
            let jsonString = try? String(contentsOfFile: filepath, encoding: .utf8),
            let jsonData = jsonString.data(using: .utf8),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let result = jsonObject as? JSON {
            return result
        } else {
            throw ServiceError.loadingFailed("Could not load or parse the file")
        }
    }

    /// Finds the filename of the stub file, assuming it is part after the last slash
    private func fileNameFrom(urlString: String) -> String {
        let lastSlashRange = urlString.range(of: "/", options: String.CompareOptions.backwards)
        let index = urlString.index(lastSlashRange!.lowerBound, offsetBy: 1)
        return urlString.substring(from: index)
    }
}
