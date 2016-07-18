import UIKit

/*:
# Transaction history screen with accounts details header

## Storyboard changes
 
1. Drag in a new **View Controller**
2. Ctrl-Drag from the accountDetailsCell, and and do a "show" selection segue. This means the new view controller will be pushed when you tap on a row. Give this segue an identifier of "transactionsSegue".
3. Add a background image to the view controller, same as you did in account details view. (Hint: equal width/height, center horizontally/vertically)
4. Add a tableView to the view controller, and set the constraints. For this one, you've set the tableView to have 8pt leading/trailing to the parent. Top constraint of 0 to the parent (no margin). And Bottom constraint of 0 to the bottom layout guide.
5. We are going to create a table header, which is a view that lives at the top of the table, above the rows. First add a row to the tableview. Then add a UIView as a child of the Table View, above that template row. Then copy the `AccountDetailsView` from the Accounts View Controller into the new Table View, as the first child of the "Table View" node. (Tip: the easiest way to do this is to Alt-Drag to copy views from one scene to another). This first view becomes the `tableHeaderView` of the table view. Rename it to "TableHeaderView".

![copyAccountDetailsView](copyAccountDetailsView.png)

- note:
The table view has children of the class `UITableViewCell`, which are templates that can be used for the repeating rows of the table.
If you add a view before the cells, this first child becomes the `tableHeaderView`, shown on top of the table, before the rows.
If you add a view after the cells, the last child becomes the `tableFooterView`, shown at the bottom of the table, after the rows.

6. Add constraints between the `AccountDetailsView` and its parent. This is how we are adding a 16pt gap between the tableHeaderView and the rest of the cells. You can use the "square tie-fighter" icon to do this:
 
![add constraint](add-constraint-tie-fighter.png)
 
![accountDetailsViewConstraints](accountDetailsViewConstraints.png)

7. Set the frame height of the table header view so that it looks nice in interface builder. (Height should be 120 + 16 = 136pt)
8. Make sure that table view's background colour is set to clear. (Tip - the background color is set towards the bottom of the properties in the attribute inspector, under the "View" section") Also make sure the TableHeaderView and the AccountDetailsView both also have clear backgrounds.
9. At this point, your storyboard should look like this:
 
![part1storyboard](part1storyboard.png)

 
## Code changes

 
1. Add a new view controller class called `TransactionsViewController`. This should be a subclass of `UIViewController`.
2. Add a property for `account`, as the previous screen will pass the account object to this screen.
 

    var account: Account!

3. In the storyboard, set this as the class for your table view controller in your storyboard.
4. Add an IBOutlet for the `AccountDetailsView`, and in `viewDidLoad()`, populate it with the details from the `Account` object. This code is pretty much identical to what you have in the `AccountsViewController`.
5. Add IBOutlets for the background image `backgroundImageView` and the `tableView`
6. Copy the code from `AccountsViewController` for `setupTableView()` and `blurImage()`, and call these in `viewDidLoad`
7. In `AccountsViewController`, override `prepareForSegue` to pass the account. Notice that the cell is the `sender`, and from that, we can get the row that was selected.

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let identifier = segue.identifier, identifier == "transactionsSegue",
            let destinationViewController = segue.destination as? TransactionsViewController {

            guard let accounts = accounts,
                let cell = sender as? UITableViewCell,
                let row = tableView.indexPath(for: cell)?.row, row < accounts.count else { return }
            destinationViewController.account = accounts[row]
        }
    }
 
7. Run the app, and you should be able to tap on an account and show the transactions screen.

8. You will notice seperator lines keep showing underneath the table, even after there is no contents. The trick is to add another view as the `tableFooterView` to the table, and if you don't need a footer, just set the height to 0

![tableFooterView](tableFooterView.png)


**Tip**

Autolayout intrinsic height of the view is not respected by the tableHeaderView.
If it is a fixed height, you can set this in the storyboard.
This is why it works for the moment.

However, if you make the account name very long, you will notice that the height doesn't automatically grow.

If you want to use a dynamic height based on autolayout,
call the method below in `viewDidLayoutSubviews()`,
after you have set the properties onto the `AccountDetailsView`
*/

var tableView: UITableView!
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



//: [Next](@next)
