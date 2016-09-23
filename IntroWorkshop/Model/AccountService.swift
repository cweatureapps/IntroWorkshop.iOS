//
//  AccountService.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 18/01/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

class AccountService {
    private var serviceHelper: ServiceHelper

    init(serviceHelper: ServiceHelper = ServiceHelperFactory.makeServiceHelper()) {
        self.serviceHelper = serviceHelper
    }

    func getAccounts(completion: @escaping (Result<[Account], ServiceError>) -> Void) {
        serviceHelper.request(urlString: ServiceURLs.getAccounts.rawValue) { result in
            switch result {
            case .success(let data):
                do {
                    let accountsResponse = try JSONDecoder().decode(AccountsResponse.self, from: data)
                    completion(.success(accountsResponse.accounts))
                } catch {
                     completion(.failure(.json))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
