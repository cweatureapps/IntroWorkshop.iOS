//
//  DashboardViewController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 3/12/2015.
//  Copyright © 2015 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    @IBOutlet weak var accountDetailsView: AccountDetailsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call account service
        AccountService().getAccounts { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let accounts):
                if let account = accounts.first {
                    this.accountDetailsView.accountName = account.accountName
                    this.accountDetailsView.accountNumber = account.accountNumber
                    this.accountDetailsView.availableFunds = account.formattedAvailableFunds
                    this.accountDetailsView.accountBalance = account.formattedAccountBalance
                }
            case .failure:
                print("something went wrong")
            }
        }
    }

}

