//
//  Transaction.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 27/03/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

struct Transaction {

    static let serverDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM yyyy"
        return formatter
    }()

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
            let parsedDate = Transaction.serverDateFormatter.date(from: effectiveDateString),
            let transactionDescription = json[JSONKeys.description] as? String,
            let amount = json[JSONKeys.amount] as? Double {

            self.id = id
            self.date = parsedDate
            let cleanedTransaction = transactionDescription.replacingOccurrences(of: "<br/>", with: "\n")
            self.transactionDescription = isPending ? "PENDING: \(cleanedTransaction)" : cleanedTransaction
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
        return Transaction.displayDateFormatter.string(from: date)
    }

    /// A user friendly String indicating how many days ago the transaction occurred. The optional param of `today` can be used for unit tests.
    func daysAgo(today: Date = Date()) -> String  {
        guard let numberOfDays = Calendar.current.dateComponents([.day], from: date, to: today).day else {
            return ""
        }
        switch numberOfDays {
        case 0:
            return "Today"
        case 1:
            return "Yesterday"
        default:
            return "\(numberOfDays) days ago"
        }
    }

    /// Parse the list of transactions from JSON, including both normal transactions and pending transactions
    static func transactionList(json: JSON) -> [Transaction] {
        var results = [Transaction]()
        if let transactionsArray = json[JSONKeys.transactions] as? [JSON] {
            results += transactionsArray.flatMap{ return Transaction(json: $0, isPending: false) }
        }
        if let pendingArray = json[JSONKeys.pending] as? [JSON] {
            results +=  pendingArray.flatMap{ return Transaction(json: $0, isPending: true) }
        }
        return results
    }


}
