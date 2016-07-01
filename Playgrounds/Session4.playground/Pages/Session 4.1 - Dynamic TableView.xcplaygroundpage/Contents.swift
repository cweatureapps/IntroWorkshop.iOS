/*:
# Session 4.1A

## Converting accounts view to a dynamic TableView

There are multiple accounts to show on screen, so we'll use a UITableView to repeat the `AccountDetailsView`

![session 4.1 design](session.4.1.png "session 4.1 design")


## Step by step instructions

## Storyboard setup

1. Add Table View to the view controller's top level view, and make it take up the whole screen. (The easiest way to do this is to to make the tableview the same width and height as the parent, and center horizontally and vertically)

 
  ![constraints to take up whole screen](easy.constraints.mp4 "constraints to take up whole screen")
 
 
2. Add 1 prototype cell to the table (by dragging a "Table View Cell" into the table), and then move the AccountDetailsView into the cell Content View

![](accountsview.in.cell.png "accountsview.in.cell")


3. Define the constraints between the AccountDetailsView and its parent, the cell Content View. Give it some left/right padding (8 leading/trailing constraint) and align it to the top (0 top constraint). Don't worry about the bottom.
 
4. We'll tell the storyboard the height of the cell. (This will be set in code later). We want a 16 gap at the bottom, so make the height 136
 
![](tableview.cell.height.png "tableview.cell.height")


## AccountDetailsViewCell class
 
Now that the `AccountDetailsView` is in a prototype cell, we don't have a reference to it any more.
 
1. Firstly, right click on the AccountDetailsView, and delete the original outlet that was there.
 
When the table is rendered, we'll be able to get a reference to the prototype cell, and from there, we can get our original AccountDetailsView again! However, it would be bad to do something like, "get the first subview of the cell", so the better approach is to make an outlet, so that we can get a strongly typed reference to the AccountDetailsView.
 
 
2. Create a new Swift class called `AccountDetailsViewCell` which is a subclass of `UITableViewCell`
3. In the storyboard, make sure the class for the cell is the new class you created
4. open up assistant editor. Have the storyboard on your left, and your new class on the right. Control-drag the AccountDetailsView to the source code to create an outlet. The final code looks like this:
 
 
 
     class AccountDetailsViewCell: UITableViewCell {
         @IBOutlet weak var accountDetailsView: AccountDetailsView!
     }
 
 

## Handling the service call response

1. In the view controller, create an outlet called `tableView` for the UITableView
 
2. Create an instance variable called `accounts`
 
 
    var accounts: [Account]?
 
3 Comment out the code where you assign the labels from the response of the service call. (You will move this code somewhere else later). Simply assign the `Account` object to the `accounts` variable. When you reload the table, it will use those accounts.


    this.accounts = accounts
    this.tableView.reloadData()

 
## Datasource and Delegate


1. The `AccountsViewController` is going to be the datasource and delegate for the table. Implement the delegate/datasource methods


    extension AccountsViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: work out the number of rows from the `accounts` variable
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let accounts = accounts where accounts.count > indexPath.row else {
            return UITableViewCell()
        }
        let account = accounts[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("accountDetailsCell", forIndexPath: indexPath) as! AccountDetailsViewCell

        // FIXME: the code you commented out earlier, move the code to here and fix it up

        return cell
    }

    extension AccountsViewController: UITableViewDelegate {
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 136.0
        }
    }

2. Make sure you have wired it up in the storyboard. You can do this by right clicking on the tableview, then drag the `dataSource` and `delegate` Outlets to the view controller.
 
 
  ![datasource.and.delegate.moview](datasource.and.delegate.mp4 "datasource.and.delegate")
 
  ![datasource.and.delegate.image](datasource.and.delegate.png "datasource.and.delegate")
 

3. Run this now and see if it works
 

 

## UI clean up

1. To bump the table down from the top of the screen, set the content inset. You can do this in `viewDidLoad`.


    tableView.contentInset = UIEdgeInsets(top: 72.0, left: 0, bottom: 0.0, right: 0.0)
 

2. You'll notice the table is not transparent yet. Make sure the entire view hierarchy is using a clear background colour. (i.e. the tableview, the cell, and the content view)
 
 
3. When you tap on a row, it gets highlighted. The following line prevents any style change when a row is selected.
 

    cell.selectionStyle = .None
 
 
 
    
## Automatic height

Try to make the rows work out their heights automatically.

1. Tell the table to use auto height

    tableView.rowHeight = UITableViewAutomaticDimension


2. And then rename `heightForRowAtIndexPath` to `estimatedHeightForRowAtIndexPath`


    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

3. Modify the storyboard and AccountDetailsView.xib to ensure that all fixed heights are removed, and that the view can determine its own intrinsic height.

**Hint:**
For the parent to determine its intrinsic height from its children, imagine you are tying pieces of string from one end to the other, making sure every sibling connects to the next sibling.
Right now, the account number label and available funds label do not have a constraint relationship. Add a vertical height constraint between them.
 
4. Remember at the beginning we didn't have a bottom constraint between the AccountDetailsView and the Content View? Add this now, so that the cell can determine its intrinsic height based on the height of the AccountDetailsView.
 
 
## Making Labels wrap
 
Let's test out the auto height. Change the JSON data to have a really long account name. Then change the account name label to wrap:

1. Set the **Lines** property of the account name label to 0
2. Give the account name label a trailing constraint to the parent
 
This won't work properly yet until we fix up the compression....
 


## Hugging, and Compression Resistance
 
There is now a couple of ambiguities... 
 
When the account name is short, the system doesn't know whether to stretch the image or the label. Change the horizontal hugging priority of the account number label to a lower priority (in other words, the account number label will not "hug" as strongly when it is narrow, and it will be allowed to grow and stretch).
 
The other problem is when the label is very long and needs to wrap, the system doesn't know whether to reduce the widdth of the image or the label. Set the compression resistance to be a lower priority. (In other words, we need to allow the label to be "compressed", so it will be allowed to squeeze and run into the next line.)

 ![hugging.and.compression](hugging.and.compression.png "hugging.and.compression")
 



*/
