//
//  Account.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 8/12/2015.
//  Copyright © 2017 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

struct Account: Codable {

    let accountName: String
    let accountNumber: String
    let availableFunds: Decimal
    let accountBalance: Decimal

    /// The account number, masked with 'X' and leaving the last 4 digits unmasked
    var maskedAccountNumber: String {
        guard accountNumber.count > 4 else { return accountNumber }
        let regex = ".(?!(.{0,3}$))"  // all but the last 4 characters
        return accountNumber.replacingOccurrences(of: regex, with: "X", options: .regularExpression)
    }
}
