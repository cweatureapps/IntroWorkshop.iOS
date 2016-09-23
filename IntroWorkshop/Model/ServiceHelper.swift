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
    typealias RequestCompletion = (Result<Data, ServiceError>) -> Void

    /// Make a request to the backend.
    func request(urlString: String, completion: @escaping RequestCompletion)
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
    case json
    case loadingFailed(String)
}

/// Service Helper class which makes a network request.
class NetworkServiceHelper: ServiceHelper {

    func request(urlString: String, completion: @escaping ServiceHelper.RequestCompletion) {
        let headers = ["Content-Type": "application/json"]
        Alamofire.request(urlString, encoding: JSONEncoding.default, headers: headers)
         .response { dataResponse in
            guard dataResponse.error == nil, let data = dataResponse.data else {
                completion(.failure(ServiceError.general))
                return
            }
            completion(.success(data))
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
    func request(urlString: String, completion: @escaping ServiceHelper.RequestCompletion) {

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Constants.delay) {
            do {
                let fileName = self.fileNameFrom(urlString: urlString)
                let data = try self.loadJSONData(from: fileName)
                completion(.success(data))
            } catch (let error) {
                let serviceError = ServiceError.loadingFailed(error.localizedDescription)
                completion(.failure(serviceError))
            }
        }
    }

    /// Loads a file from disk as a dictionary
    private func loadJSONData(from filename: String) throws -> Data {
        let splitFilename = filename.components(separatedBy: ".")
        guard let filepath = Bundle(for: StubServiceHelper.self).path(forResource: splitFilename[0], ofType: splitFilename[1]),
            let jsonString = try? String(contentsOfFile: filepath, encoding: .utf8),
            let data = jsonString.data(using: .utf8) else {
            throw ServiceError.loadingFailed("Could not load or parse the file")
        }
        return data
    }

    /// Finds the filename of the stub file, assuming it is part after the last slash
    private func fileNameFrom(urlString: String) -> String {
        let lastSlashRange = urlString.range(of: "/", options: String.CompareOptions.backwards)
        let index = urlString.index(lastSlashRange!.lowerBound, offsetBy: 1)
        return String(urlString[index...])
    }
}
