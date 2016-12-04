//
//  TransactionsViewController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 4/12/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {

    fileprivate enum Constants {
        static let startingEdgeInsets = UIEdgeInsets(top: 72.0, left: 0, bottom: 0.0, right: 0.0)
        static let noTopMarginEdgeInsets = UIEdgeInsets(top: 0.0, left: 0, bottom: 16.0, right: 0.0)
        static let navBarHiddenThreshold: CGFloat = -64.0       // Status bar is 20pt, Nav bar is 44pt
        static let statusBarHiddenThreshold: CGFloat = -54.0
    }

    var account: Account!

    fileprivate var transactions: [GroupedTransactions]?
    fileprivate lazy var accountsManager: AccountsManager = AccountsManager()

    @IBOutlet weak var accountDetailsView: AccountDetailsView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        populateAccountsView()
        setupTableView()
        blurImage()
        getTransactions()
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

    private func getTransactions() {
        accountsManager.getTransactions(account: account) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let transactionsByDate):
                this.transactions = transactionsByDate
                this.tableView.reloadData()
            case .failure:
                print("something went wrong")
            }
        }
    }

    // MARK: Status bar and Nav bar handling

    fileprivate var statusBarHidden = false

    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return transactions?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let transactions = transactions, section < transactions.count else { return 0 }
        return transactions[section].transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transactions = transactions else { return UITableViewCell() }
        let transaction = transactions[indexPath.section].transactions[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionAmountCell", for: indexPath) as! TransactionCell
        cell.descriptionString = transaction.transactionDescription
        cell.amount = transaction.formattedAmount

        if indexPath.row == transactions[indexPath.section].transactions.count - 1 {
            cell.seperatorHidden = true
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let transactions = transactions,
            let firstTransaction = transactions[section].transactions.first else { return nil }

        let headerView = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! TransactionSectionHeaderCell
        headerView.dateString = firstTransaction.formattedDate
        headerView.daysAgo =  firstTransaction.daysAgo()

        return headerView.contentView
    }
}

extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 16.0
    }
}

extension TransactionsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // adjust navigation bar
        navigationController?.setNavigationBarHidden(scrollView.contentOffset.y > Constants.navBarHiddenThreshold, animated: true)

        // adjust status bar
        statusBarHidden = tableView.contentOffset.y > Constants.statusBarHiddenThreshold
        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()  // this will call prefersStatusBarHidden()
        }

        // adjust content inset
        if scrollView.contentOffset.y > 0 {
            scrollView.contentInset = Constants.noTopMarginEdgeInsets
        } else {
            scrollView.contentInset = Constants.startingEdgeInsets
        }
    }
}
