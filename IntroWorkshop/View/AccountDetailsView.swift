//
//  AccountDetailsView.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 13/03/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

@IBDesignable
class AccountDetailsView: NibDesignableView {

    @IBOutlet private weak var accountNameLabel: UILabel!
    @IBOutlet private weak var accountNumberLabel: UILabel!
    @IBOutlet private weak var availableFundsLabel: UILabel!
    @IBOutlet private weak var accountBalanceLabel: UILabel!

    @IBInspectable
    var accountName: String? {
        didSet {
            accountNameLabel.text = accountName
        }
    }

    @IBInspectable
    var accountNumber: String? {
        didSet {
            accountNumberLabel.text = accountNumber
        }
    }

    @IBInspectable
    var availableFunds: String? {
        didSet {
            availableFundsLabel.text = availableFunds
        }
    }

    @IBInspectable
    var accountBalance: String? {
        didSet {
            accountBalanceLabel.text = accountBalance
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        if accountName == nil {
            accountNameLabel.text = nil
        }
        if accountNumber == nil {
            accountNumberLabel.text = nil
        }
        if availableFunds == nil {
            availableFundsLabel.text = nil
        }
        if accountBalance == nil {
            accountBalanceLabel.text = nil
        }
    }

    @IBAction func tapGestureRecognizerTapped(_ sender: Any) {
        UIPasteboard.general.string = accountNumberLabel.text
        print("Copied to pasteboard")
    }

    // MARK - Designer support

    override var designerView: UIView? {
        didSet {
            guard let designerView = designerView as? AccountDetailsView else { return }

            // setup the IBOutlet manually for designer
            accountNameLabel = designerView.accountNameLabel
            accountNumberLabel = designerView.accountNumberLabel
            availableFundsLabel = designerView.availableFundsLabel
            accountBalanceLabel = designerView.accountBalanceLabel
        }
    }

    // if you want the designer to always have some static data
    override func prepareForInterfaceBuilder() {
        accountNameLabel.text = "[account name]"
        accountNumberLabel.text = "[account number]"
        availableFundsLabel.text = "[$0,000.00]"
        accountBalanceLabel.text = "[$0,000.00]"
    }
}
