//
//  GroupedTransactions.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 29/03/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

/// Represents a list of transactions which all have the same date.
class GroupedTransactions: CustomStringConvertible {
    let date: Date
    var transactions: [Transaction]
    init(date: Date, transactions: [Transaction]) {
        self.date = date
        self.transactions = transactions
    }
    var description: String {
        return "date: \(date), transactions: \(transactions)"
    }
}
