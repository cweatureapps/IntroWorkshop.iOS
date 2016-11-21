//: [Previous](@previous)

/*:

## Part 2

In the second half of this session, we refactor the view into `AccountDetailsView`,
so that we can reuse this tile for every account, and also on the drilldown transaction details screen.


**Topics**

* UIView and Xib
* UIView lifecycle
* Adding designer support (Demo)


## Extract to Xib
 
If you have a view you want to reuse in more than one place, you can extract it to a view file, referred to as a Xib or a Nib. This is an XML file in the Interface Builder format with a `.xib` extension, similar to a storyboard file, used to define individual view(s).
 
To extract a part of our storyboard to a Xib, simply copy and paste.
 
1. Select the account details view in our storyboard
2. Cmd-C to copy
3. Right click the "View" folder in the navigator. Choose "New file...", "User interface", "View"
4. Call it "AccountDetailsView.xib"
5. In interface builder, delete the blank View which is already there
 
![delete view](delete.view.png "delete view")

6. Cmd-V to paste
7. In the simulated metrics, set the size to "freeform"
 
![accountdetails.simulated.metrics](accountdetails.simulated.metrics.png "accountdetails.simulated.metrics")

8. In the size inspector, set the height to 120
 
![accountdetails.size](accountdetails.size.png "accountdetails.size")

9. It should look ok now:
 
![accountdetails.xib](accountdetails.xib.png "accountdetails.xib")
 


## Swift code

Add a New File, "Coacoa Touch class", subclassing `UIView`. Call it `AccountDetailsView.swift`
 
    class AccountDetailsView: UIView {
    }


Cut and paste the outlets from the view controller swift file into this view class
 
 
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var availableFundsLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!


Override the method `awakeFromNib()` to clear out any dummy text you have set in the Xib file, to ensure you don't see any of the dummy text before the real text loads. 
 
This code to set the text to nil is already in the view controller. Cut and paste the code from the view controller file so that it's removed from the view controller.

    override func awakeFromNib() {
        super.awakeFromNib()
        accountNameLabel.text = nil
        // etc...
    }



Add this code to the `AccountDetailsView` class so that it can load itself from the Xib file. This is how a view knows to load from a Xib, rather than from the storyboard. (More on this later.)

    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        super.awakeAfter(using: aDecoder)
        return viewFromNib()
    }



In views, we often try to encapsulate the internal implementation, and just expose the values we want to set/get. Specifically, don't expose the inner views and controls (e.g. the labels) but expose the Strings you want to set to each label.
 
    var accountName: String? {
        didSet {
            accountNameLabel.text = accountName
        }
    }

 Do this for all 4 labels, and then you can make the `IBOutlet` properties `private`.


 
## Wire up the outlets
 
Similar to when you created outlets in the storyboard, you do the same for Xib and the view class.
 
Because we've already pasted in the code with the `@IBOutlet`, when you Ctrl-drag this time, just drag it over the line of code, and it will wire it up.

Do this for all 4 labels.

 ![ctrl drag outlet](ctrl.drag.outlet.mp4 "ctrl drag outlet")

 
## Reference the reusable view
 
In the storyboard, delete all the subviews. We don't need these anymore because we'll just reference our reusable view.

![accountdetails.sb.delete](accountdetails.sb.delete.png "accountdetails.sb.delete")

 
Then select the view from the view hierarchy, and specify the AccountDetailsView class

![accountdetails.class](accountdetails.class.png "accountdetails.class")

 
Finally, for the view controller, create an `IBOutlet` for the `AccountDetailsView` by ctrl-dragging.

Then fix up your code so that it compiles. When the service returns, it will set the values into the AccountDetailsView.
 
    this.accountDetailsView.accountName = account.accountName
    // etc...
 
 
 
## All done!
 
Well done on getting here! 👍😎
 
If you've followed all the instructions correctly, you should be able to run the app now, and it should look exactly the same as before.

This account details view can now be used as a repeating view to show a number of accounts in a table, and can also be used on another screen (like at the top of the transaction history screen).
 
 

## But wait... how does it work?
 
Here's what the system is doing...
 
1. It decodes the storyboard, and loads up what is in the storyboard.
2. The view that has a class of `AccountDetailsView`. It puts the view through the view lifecycle.
3. This class overrides `awakeAfter(using:)` and swaps out a different view by decoding and loading `AccountDetailsView.xib` instead. This is essentially saying, ignore what's in the storyboard, just load this Xib instead.
 

*/







//: [Next](@next)
