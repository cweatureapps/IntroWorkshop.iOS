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
        serviceHelper.request(urlString: ServiceURLs.getAccounts.rawValue, param: nil) { result in
            switch result {
            case .success(let json):
                let accounts = Account.accountList(json: json)
                completion(.success(accounts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
