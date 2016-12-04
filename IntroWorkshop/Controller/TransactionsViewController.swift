//
//  TransactionsViewController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 4/12/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {

    private enum Constants {
        static let startingEdgeInsets = UIEdgeInsets(top: 72.0, left: 0, bottom: 0.0, right: 0.0)
    }

    var account: Account!

    @IBOutlet weak var accountDetailsView: AccountDetailsView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        populateAccountsView()
        setupTableView()
        blurImage()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
    }

    private func populateAccountsView() {
        accountDetailsView.accountName = account.accountName
        accountDetailsView.accountNumber = account.accountNumber
        accountDetailsView.availableFunds = account.formattedAvailableFunds
        accountDetailsView.accountBalance = account.formattedAccountBalance
    }

    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = Constants.startingEdgeInsets
    }

    private func blurImage() {
        let blurImage = UIImageEffects.imageByApplyingBlur(to: backgroundImageView.image, withRadius: 40, tintColor: UIColor.clear, saturationDeltaFactor: 1.2, maskImage: nil)
        backgroundImageView.image = blurImage
    }

    func sizeHeaderToFit() {
        guard let headerView = tableView.tableHeaderView else { return }

        // detect autolayout height
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height

        // set the frame
        headerView.frame = {
            var frame = headerView.frame
            frame.size.height = height
            return frame
        }()

        // need to reassign for it to take effect
        tableView.tableHeaderView = headerView
    }
}
