//
//  Account.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 8/12/2015.
//  Copyright © 2015 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

struct Account {

    private enum JSONKeys {
        static let accounts = "accounts"
        static let accountName = "accountName"
        static let accountNumber = "accountNumber"
        static let availableFunds = "availableFunds"
        static let accountBalance = "accountBalance"
    }

    let accountName: String
    let accountNumber: String
    let availableFunds: Double
    let accountBalance: Double

    /// The account number, masked with 'X' and leaving the last 4 digits unmasked
    var maskedAccountNumber: String {
        guard accountNumber.characters.count > 4 else { return accountNumber }
        let regex = ".(?!(.{0,3}$))"  // all but the last 4 characters
        return accountNumber.replacingOccurrences(of: regex, with: "X", options: .regularExpression)
    }

    init(accountName: String, accountNumber: String, availableFunds: Double, accountBalance: Double) {
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.availableFunds = availableFunds
        self.accountBalance = accountBalance
    }

    init?(json: JSON) {
        guard let accountName = json[JSONKeys.accountName] as? String,
            let accountNumber = json[JSONKeys.accountNumber] as? String,
            let availableFunds = json[JSONKeys.availableFunds] as? Double,
            let accountBalance = json[JSONKeys.accountBalance] as? Double else { return nil }

        self.init(accountName: accountName, accountNumber: accountNumber, availableFunds: availableFunds, accountBalance: accountBalance)
    }

    static func accountList(json: JSON) -> [Account] {
        var results = [Account]()
        if let accountsArray = json[JSONKeys.accounts] as? [[String: AnyObject]] {
            for item in accountsArray {
                let account = Account(json: item)
                if let account = account {
                    results.append(account)
                }
            }
        }
        return results
    }
}
