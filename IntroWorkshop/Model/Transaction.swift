//
//  Transaction.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 27/03/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

struct Transaction {

    static var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_AU")
        return formatter
    }()

    private struct JSONKeys {
        static let id = "id"
        static let effectiveDate = "effectiveDate"
        static let description = "description"
        static let amount = "amount"
        static let transactions = "transactions"
        static let pending = "pending"
    }

    let id: String
    let date: Date
    let transactionDescription: String
    let amount: Double
    let isPending: Bool

    init(id: String, date: Date, transactionDescription: String, amount: Double, isPending: Bool) {
        self.id = id
        self.date = date
        self.transactionDescription = transactionDescription
        self.amount = amount
        self.isPending = isPending
    }

    init?(json: JSON, isPending: Bool) {
        if let id = json[JSONKeys.id] as? String,
            let effectiveDateString = json[JSONKeys.effectiveDate] as? String,
            let transactionDescription = json[JSONKeys.description] as? String,
            let amount = json[JSONKeys.amount] as? Double {

            self.id = id
            self.date = Date() // FIXME: this should come from effectiveDateString
            self.transactionDescription = transactionDescription  // FIXME: remove the "<br/>" chracters from the lines
            self.amount = amount
            self.isPending = isPending
            return
        }
        return nil
    }

    var formattedAmount: String {
        return Transaction.formatter.string(from: NSNumber(value: amount)) ?? ""
    }

    /// The transaction date in the correct format
    var formattedDate: String {
        // FIXME: use DateFormatter to format
        return "Fri 22 Jan 2016"
    }

    /// A user friendly String indicating how many days ago the transaction occurred. The optional param of `today` can be used for unit tests.
    func daysAgo(today: Date = Date()) -> String  {
        // FIXME: calculate how many days ago since right now. Handle the cases of "Yesterday" and "Today".
        // Hint: For unit testing, you can use the dateProvider property to inject a stub object which returns a specific Date for right now.
        return "2 days ago"
    }

    /// Parse the list of transactions from JSON, combining both normal transactions and pending transactions in a single list
    static func transactionList(json: JSON) -> [Transaction] {
        // FIXME: replace the use of `forEach` below, and use `flatMap` instead
        var results = [Transaction]()
        if let transactionsArray = json[JSONKeys.transactions] as? [JSON] {
            transactionsArray.forEach { json in
                guard let trasaction = Transaction(json: json, isPending: false) else { return }
                results.append(trasaction)
            }
        }
        if let pendingArray = json[JSONKeys.pending] as? [JSON] {
            pendingArray.forEach { json in
                guard let trasaction = Transaction(json: json, isPending: true) else { return }
                results.append(trasaction)
            }
        }
        return results
    }

}
