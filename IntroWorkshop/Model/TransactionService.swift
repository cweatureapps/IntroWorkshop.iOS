//
//  TransactionService.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 27/03/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//


import Foundation

class TransactionService {
    var serviceHelper: ServiceHelper

    init(serviceHelper: ServiceHelper = ServiceHelperFactory.makeServiceHelper()) {
        self.serviceHelper = serviceHelper
    }

    func getTransactions(account: Account, completion:  @escaping (Result<[Transaction], ServiceError>) -> Void) {
        serviceHelper.request(urlString: ServiceURLs.getTransactions.rawValue, param: account.id) { result in
            switch result {
            case .success(let json):
                let transactions = Transaction.transactionList(json: json)
                completion(.success(transactions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
