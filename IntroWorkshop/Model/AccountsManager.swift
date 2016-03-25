//
//  AccountsManager.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 27/03/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

class AccountsManager {

    var accountService: AccountService
    var transactionService: TransactionService

    init(accountService: AccountService = AccountService(),
         transactionService: TransactionService = TransactionService()) {
        self.accountService = accountService
        self.transactionService = transactionService
    }

    func getAccounts(completion: @escaping (Result<[Account], ServiceError>) -> Void) {
        accountService.getAccounts { result in
            switch result {
            case .success(let accounts):
                completion(.success(accounts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
