//
//  AccountsManager+Transactions.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 17/07/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

extension AccountsManager {
    /// Get the transactions, sorted by date descending and with pending transactions first, and grouped by date.
    func getTransactions(account: Account, completion: @escaping (Result<[GroupedTransactions], ServiceError>) -> Void) {
        transactionService.getTransactions(account: account) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let transactions):
                completion(.success(this.groupedTransactions(for: transactions)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func groupedTransactions(for transactions: [Transaction]) -> [GroupedTransactions] {
        // FIXME: This is a dummy implementation. Please implement this correctly. Hint: use sort and reduce.
        return [GroupedTransactions(date: Date(), transactions: transactions)]
    }
}
