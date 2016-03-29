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
        static let id = "id"
        static let accounts = "accounts"
        static let accountName = "accountName"
        static let accountNumber = "accountNumber"
        static let availableFunds = "availableFunds"
        static let accountBalance = "accountBalance"
    }

    let id: String
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

    init(id: String, accountName: String, accountNumber: String, availableFunds: Double, accountBalance: Double) {
        self.id = id
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.availableFunds = availableFunds
        self.accountBalance = accountBalance
    }

    init?(json: JSON) {
        guard let id =  json[JSONKeys.id] as? String, 
            let accountName = json[JSONKeys.accountName] as? String,
            let accountNumber = json[JSONKeys.accountNumber] as? String,
            let availableFunds = json[JSONKeys.availableFunds] as? Double,
            let accountBalance = json[JSONKeys.accountBalance] as? Double else { return nil }

        self.init(id: id, accountName: accountName, accountNumber: accountNumber, availableFunds: availableFunds, accountBalance: accountBalance)
    }

    static func accountList(json: JSON) -> [Account] {
        guard let accountsArray = json[JSONKeys.accounts] as? [JSON] else { return [] }
        return accountsArray.flatMap{ return Account(json: $0) }
    }
}

extension Account {

    private static var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_AU")
        return formatter
    }()

    var formattedAvailableFunds: String {
        return Account.formatter.string(from: NSNumber(value: availableFunds)) ?? ""
    }

    var formattedAccountBalance: String {
        return Account.formatter.string(from: NSNumber(value: accountBalance)) ?? ""
    }
}
