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
        // sort descending by date, and also sort the pending transactions first
        let sortedTransactions = transactions.sorted { t1, t2 in
            let comparisonResult = t1.date.compare(t2.date)
            if comparisonResult == .orderedSame {
                return t1.isPending
            } else {
                return comparisonResult == .orderedDescending
            }
        }
        // group the transactions by date
        return sortedTransactions.reduce([]) { inProgress, transaction in
            if let last = inProgress.last, last.date == transaction.date {
                last.transactions.append(transaction)
                return inProgress
            } else {
                return inProgress + [GroupedTransactions(date: transaction.date, transactions: [transaction])]
            }
        }
    }
}
