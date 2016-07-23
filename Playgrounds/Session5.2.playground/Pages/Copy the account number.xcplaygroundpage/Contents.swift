/*:
# Exercises - Copy the account number
 
This exercise demonstrates the following concepts:
 
* Gesture Recognizer
* Delegation
* Alerts and ActionSheets
* Sharing sheet
 
 
## Gesture Recognizer

1. Drag a Tap Gesture Recognizer into the AccountDetailsView.xib
2. For the account number label, ensure "User Interaction Enabled" is checked. (Attributes inspector, in the View section)
3. Ctrl-drag from the account number label to the gesture recognizer, to add gesture recognizer to the label
4. Open assistant editor, and Ctrl-drag into the AccountDetailsView.swift view code, and create an IBAction called `tapGestureRecognizerTapped`. In the implementation, you will copy the account number to the pasteboard:
 
 
    @IBAction func tapGestureRecognizerTapped(sender: AnyObject) {
        UIPasteboard.general.string = accountNumberLabel.text
        print("Copied to pasteboard")
    }
 
5. Run it and tap on the account number. The segue won't happen, and you can see the message printed in the console. 
6. With the focus in the simulator, use the shortcut `Cmd-C` to copy the simulator pasteboard into the Mac system pasteboard. Note also that doing `Cmd-V` in the simulator will replace the simulator pasteboard with the value from the Mac system pasteboard (to paste something into the simulator).

 
 
Homework: 
 
* Try changing the settings on the tap gesture recognizer (e.g. make it 2 fingers) or do the same thing with a different gesture recognizer (e.g. the long press gesture recognizer)
 
* Try adding a gesture recognizer to a view controller on a storyboard, rather than a Xib file. The mechanics are the same, but IB shows the information slightly differently.
*/


/*:

## Delegation
 
In the example above, we hardcoded some behaviour into the view.
But this is bad, because we don't know how this view may be used, and it's really up to the controller to decide what to do. (E.g. we may navigate somewhere else, call a service, etc.)
 
This is where the delegation pattern comes in. 
 
The view will be given a delegate, which can handle things which happen within the view, i.e. **"hey delegate, the account number label has been tapped, do something about it"**
 
 
Create a new protocol:


    protocol AccountDetailsViewDelegate: class {
        func accountNumberLabelTapped(accountNumber: String)
    }
 
 
Add a new property to `AccountDetailsView`:
 

    weak var delegate: AccountDetailsViewDelegate?
 
The tap gesture recognizer IBAction now looks like this:
 

    @IBAction func tapGestureRecognizerTapped(sender: AnyObject) {
        delegate?.accountNumberLabelTapped(accountNumber: accountNumberLabel.text ?? "")
    }
 
The AccountsViewController will be the delegate:
 

    extension AccountsViewController: AccountDetailsViewDelegate {
        func accountNumberLabelTapped(accountNumber: String) {
            UIPasteboard.general.string = accountNumber
            print("Copied to pasteboard")
        }
    }
 
So in `cellForRowAtIndexPath`, set the delegate:
 

    cell.accountDetailsView.delegate = self
 
*/




/*:
 
## Alerts and Action Sheets

This is how you present an alert on iOS. Replace the `print` statement with a property alert.
 
    let alertController = UIAlertController(title: "Information", message: "Copied to pasteboard", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style:.default) { _ in
        // do something
    }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)


Notice how you can add multiple `UIAlertAction`, and each action has a closure where you can do something.
Change it so that there is a cancel button (note also the `style` property), and only copy to pasteboard when the person taps OK.
 
![alert.png](alert.png)
*/



/*:
 
## Sharing Sheet
 
iOS has a default sharing sheet where you can share information from your app to other places. Change the implementation of the delegate method to the following:
 
        let activityViewController = UIActivityViewController(activityItems: [accountNumber], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.airDrop]
        present(activityViewController, animated: true, completion: nil)
 
 
You'll see something like this, which has the Copy function by default
 
![sharesheet](sharesheet.png)
 
If you want more information on the `UIActivityViewController`, have a look at this link:
 

[http://nshipster.com/uiactivityviewcontroller/](http://nshipster.com/uiactivityviewcontroller/)

It also includes examples of how to invoke various types of sharing manually.
 
*/


//: [Next](@next)


