//
//  AccountDetailsView.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 13/03/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class AccountDetailsView: UIView {

    @IBOutlet private weak var accountNameLabel: UILabel!
    @IBOutlet private weak var accountNumberLabel: UILabel!
    @IBOutlet private weak var availableFundsLabel: UILabel!
    @IBOutlet private weak var accountBalanceLabel: UILabel!

    var accountName: String? {
        didSet {
            accountNameLabel.text = accountName
        }
    }

    var accountNumber: String? {
        didSet {
            accountNumberLabel.text = accountNumber
        }
    }

    var availableFunds: String? {
        didSet {
            availableFundsLabel.text = availableFunds
        }
    }

    var accountBalance: String? {
        didSet {
            accountBalanceLabel.text = accountBalance
        }
    }

    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        super.awakeAfter(using: aDecoder)
        return viewFromNib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        accountNameLabel.text = nil
        accountNumberLabel.text = nil
        availableFundsLabel.text = nil
        accountBalanceLabel.text = nil
    }
}
