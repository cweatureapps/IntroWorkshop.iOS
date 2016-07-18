//: [Previous](@previous)

/*:
 
# Transaction history screen - table cells and section header

### Storyboard and Code

We'll now implement the visual design for the table which shows the transactions.

1. You should already have a Table View Cell in the table. Let's use this first one as the section header. Use autolayout to position two UILabel inside the cell. This cell can have a fixed height. Give the cell the identifier of "headerCell".

![sectionHeaderRowHeight](sectionHeaderRowHeight.png)
![headerIdentifier](headerIdentifier.png)

2. Add another Table View Cell to the table view. This will be the rows inside each section. Use autolayout to position the two UILabels inside the cell. Because this cell will need to work out its own height, make sure the cell has intrinsic height based on the autolayout. (i.e. the description label should have top and bottom constraints to the superview). Give the cell the identifier of "descriptionAmountCell".

3. Give this cell a clear colour background, and add a UIView to make the semi-transparent background

4. Create classes for each cell. Name the transaction cell `TransactionCell` and the header cell `TransactionSectionHeaderCell`. They should both be subclasses of `UITableViewCell`. Assign the classes to the cells in the storyboard.

- note:
Using the prototype cell (which is a `UITableViewCell`) as the section header is technically a hack. The proper way is to extract it to a Xib file and load that up as the header... but that is additional complexity if you dont need to use those cells elsewhere. This approach we are taking for now is simpler, and works fine.

5. Do the usual thing to add IBOutlets for the labels, so that we can access them programmatically later to set the text. For each class, expose String properties to set the values of the labels.
 
** TransactionCell **

* descriptionString
* amount
 
**TransactionSectionHeaderView**
 
* dateString
* daysAgo
 

5. In `TransactionsViewController` you will need to retrieve transactions during `viewDidLoad`. When you sucessfully retrieve them, save them to a property called `transactions`, and then call `tableView.reloadData()`



    fileprivate var transactions: [GroupedTransactions]?
    fileprivate lazy var accountsManager: AccountsManager = AccountsManager()
 
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

### DataSource and Delegate

1. We will implement the methods which tell the UITableView about its datasource. The following methods tell the table how many sections there are, and how many rows in each section.
 
    (Don't worry, this doesn't compile until we do the next few steps)


    extension TransactionsViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return transactions?.count ?? 0
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let transactions = transactions, section < transactions.count else { return 0 }
            return transactions[section].transactions.count
        }
 
        // FIXME: step 2 here
 
        // FIXME: step 3 here
    }


2. `cellForRowAtIndexPath` is the method that is called for every row, and for each row, you tell it what cell to load, and it gives you an opportunity to set data into each cell (e.g. set the labels). Pay special attention to the method `dequeueReusableCellWithIdentifier`. Notice how we used the identifier we set on the storyboard to find the right prototype cell to load. Add this code to the extension as well.


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transactions = transactions else { return UITableViewCell() }
        let transaction = transactions[indexPath.section].transactions[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionAmountCell", for: indexPath) as! TransactionCell
        cell.descriptionString = transaction.transactionDescription
        cell.amount = transaction.formattedAmount

        return cell
    }


3. Similarly, `viewForHeaderInSection` is called once for each section to find out what view to use for the section header. Notice we are returning the `contentView` of the cell, rather than the prototype cell. (We shouldn't use UITableViewCell for a section header). Add this code to the extension as well.


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let transactions = transactions,
            let firstTransaction = transactions[section].transactions.first else { return nil }

        let headerView = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! TransactionSectionHeaderCell
        headerView.dateString = firstTransaction.formattedDate
        headerView.daysAgo =  firstTransaction.daysAgo()

        return headerView.contentView
    }

4. To make the section header have a black background, make sure that you've set the background colour on the `contentView`, rather than the prototype cell itself.


5. You will also need to tell the tableview the estimated row heights


    extension TransactionsViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 48.0
        }

        func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
            return 16.0
        }
    }
 
6 Now that the view controller conforms to the `UITableViewDataSource` and `UITableViewDelegate`, wire them up in the storyboard.

 ![wireup-datasource-delegate.mp4](wireup-datasource-delegate.mp4)
 
 
 
 
### Seperators

1. The tableview's built in seperators don't look very good, so turn them off from the tableview's properties.
 
2. Implement your own using a UIView, sized to look like a line at the bottom of the cell. You'll want to add IBOutlets to the `TransacitonCell` for the `seperatorView`, as well as the height constraint `seperatorHeightConstraint`. We'll be changing the height in the next step.

3. In order to get the line to a 1px height, you'll have to do it in code. (You can only set it to 1pt on the storyboard, but this may be 1px, 2px or 3px depending on your device). In the `TransactionCell`, add this method:


    override func layoutSubviews() {
        super.layoutSubviews()
        seperatorHeightConstraint.constant = 1 / UIScreen.main.scale
    }

4. To be extra tidy, add some code to hide the seperator lines for the last row in each section. 
 
   Add a Bool property `seperatorHidden` to `TransactionCell` to expose showing/hiding the seperator. 
 

     var seperatorHidden: Bool = false {
        didSet {
            seperatorView.isHidden = seperatorHidden
        }


    Then add the following code to the controller's `cellForRowAtIndexPath`:
 
 
    if indexPath.row == transactions[indexPath.section].transactions.count - 1 {
        cell.seperatorHidden = true
    }


 

### Cell reuse... reset! reset!
 
Hey, it's all looking really good now! The seperators look great. And scroll all the way to the bottom, and you can see the last cell doesn't have a seperator. Scroll back to the top and... wait a minute... the seperator disappeared on one of the other cells... what's going on?
 
 This is a common mistake that is made! For performance reasons, we always reuse cells. What's happened here is one of the cells on top has reused the last cell which had the seperator turned off. Remember when using reusable cells, you need to override a method called `prepareForReuse` where you reset the state of your cell. Add this to the `TransactionCell` class:

 
 
    override func awakeFromNib() {
        resetCell()
    }

    override func prepareForReuse() {
        resetCell()
    }

    private func resetCell() {
        descriptionString = ""
        amount = ""
        seperatorHidden = false
    }
 

 

### Hiding the navigation and status bars
 
You can see that the navigation bar area won't look very good when you scroll.

We'll nowhide the navigation bar and status bars when the table is scrolled up. See this movie from the result we are trying to achieve.
 
![hideAndShowNavAndStatusBar.mp4](hideAndShowNavAndStatusBar.mp4)
 

Paste this code into the `TransactionsViewController`
 

    fileprivate enum Constants {
        static let startingEdgeInsets = UIEdgeInsets(top: 72.0, left: 0, bottom: 0.0, right: 0.0)
        static let noTopMarginEdgeInsets = UIEdgeInsets(top: 0.0, left: 0, bottom: 16.0, right: 0.0)
        static let navBarHiddenThreshold: CGFloat = -64.0       // Status bar is 20pt, Nav bar is 44pt
        static let statusBarHiddenThreshold: CGFloat = -54.0
    }
 
    // MARK: Status bar and Nav bar handling

    fileprivate var statusBarHidden = false

    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
 
 
Add this as an extension to `TransactionsViewController` so that it can handle the scrolling for the tableview. When the `delegate` is also a `UIscrollViewDelegate`, it will handling the scrolling behaviour.
 

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
 
 
 
### Congratulations!!!
 
Congratulations! If you've made it this far, the transaction view screen is all implemented!



*/




//: [Next](@next)
