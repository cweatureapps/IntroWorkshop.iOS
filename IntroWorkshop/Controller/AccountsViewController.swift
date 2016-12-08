//
//  DashboardViewController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 3/12/2015.
//  Copyright © 2015 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    private enum Constants {
        static let startingEdgeInsets = UIEdgeInsets(top: 72.0, left: 0, bottom: 0.0, right: 0.0)
    }

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    fileprivate lazy var accountManager: AccountsManager = AccountsManager()
    
    fileprivate var accounts: [Account]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        blurImage()

        // call account manager
        accountManager.getAccounts { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let accounts):
                this.accounts = accounts
                this.tableView.reloadData()
            case .failure:
                print("something went wrong")
            }
        }
    }

    private func setupNavBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }

    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = Constants.startingEdgeInsets
    }

    private func blurImage() {
        let blurImage = UIImageEffects.imageByApplyingBlur(to: backgroundImageView.image, withRadius: 40, tintColor: UIColor.clear, saturationDeltaFactor: 1.2, maskImage: nil)
        backgroundImageView.image = blurImage
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let identifier = segue.identifier, identifier == "transactionsSegue",
            let destinationViewController = segue.destination as? TransactionsViewController {

            guard let accounts = accounts,
                let cell = sender as? UITableViewCell,
                let row = tableView.indexPath(for: cell)?.row, row < accounts.count else { return }
            destinationViewController.account = accounts[row]
        }
    }

}

extension AccountsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let accounts = accounts, accounts.count > indexPath.row else {
            return UITableViewCell()
        }
            let account = accounts[indexPath.row]

            let cell = tableView.dequeueReusableCell(withIdentifier: "accountDetailsCell", for: indexPath) as! AccountDetailsViewCell
            cell.accountDetailsView.accountName = account.accountName
            cell.accountDetailsView.accountNumber = account.accountNumber
            cell.accountDetailsView.availableFunds = account.formattedAvailableFunds
            cell.accountDetailsView.accountBalance = account.formattedAccountBalance

            cell.selectionStyle = .none
            cell.accountDetailsView.delegate = self
        return cell
    }
}

extension AccountsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension AccountsViewController: AccountDetailsViewDelegate {
    func accountNumberLabelTapped(accountNumber: String) {
        // copyToPasteboardAlert(accountNumber: accountNumber)
        showShareSheet(accountNumber: accountNumber)
    }

    private func showShareSheet(accountNumber: String) {
        let activityViewController = UIActivityViewController(activityItems: [accountNumber], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.airDrop]
        present(activityViewController, animated: true, completion: nil)
    }

    private func copyToPasteboardAlert(accountNumber: String) {
        let alertController = UIAlertController(title: "", message: "Copy \"\(accountNumber)\" to pasteboard?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            UIPasteboard.general.string = accountNumber
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
