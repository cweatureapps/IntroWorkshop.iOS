//
//  DashboardViewController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 3/12/2015.
//  Copyright © 2015 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var availableFundsLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        accountNameLabel.text = nil
        accountNumberLabel.text = nil
        availableFundsLabel.text = nil
        accountBalanceLabel.text = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call account service
        AccountService().getAccounts { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let accounts):
                if let account = accounts.first {
                    this.accountNameLabel.text = account.accountName
                    this.accountNumberLabel.text = account.accountNumber
                    this.availableFundsLabel.text = account.formattedAvailableFunds
                    this.accountBalanceLabel.text = account.formattedAccountBalance
                }
            case .failure:
                print("something went wrong")
            }
        }
    }

}

