//: [Previous](@previous)


//: # Part 1 - Introduction to navigation

/*: 
## Final storyboard
It should look something similar to this:

![navigation demo](navigation-demo.png)

*/

/*:
## Setup new storyboard

Let's create a new storyboard to do an intro to navigation

* Add a new storyboard to the project, call it `NavigationDemo.storyboard`
* Add a view controller to the storyboard.
* In the storyboard, embed the first view controller in a navigation controller (Editor->Embed in->Navigation controller)
* Make the navigation controller the initial view controller
* In the project settings, make this storyboard the main interface, so that the app launches this storyboard instead:

![changing the main interface](change-main-interface.png)
*/

/*:
## Push/Pop navigation

Use Push/Pop navigation (called "Show" in Interface Builder) when you need to move to screens in the same level of the navigation hierarchy. E.g. pages of a wizard, or the user is completing the same task.

* Add a bar button to top right, which will *show* another view controller
* Add classes for `FirstViewController` and `SecondViewController`
* Customize the text of the back button. (Hint: do it on the first view controller's NavigationItem)
* Try to get rid of the back button text completely. In `FirstViewController`:


    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

*/


/*:
## Modal presentation

Use a modal presentation (called "Present modally" in Interface Builder) when you need to take to user to a screen to complete a different task or navigation flow.

* Add a bar button to the top left of the first view controller, which will *present modally* another view controller. Notice the new flow created by the modal has no navigation.
* The presented view controller will also need to be embedded in its own navigation controller.
*/


/*:
## Unwind (exit) segues

* To close the modal, you will need to add an unwind segue to the presented view controller, so that you can go back to the first view controller. In order to do this, you need to first add this code to the view controller you want to unwind to (i.e. `FirstViewController`):


    @IBAction func unwindToFirstViewController(segue: UIStoryboardSegue) {
    }

* Then you can control-drag from a bar button, to the exit icon on top. Pick the unwind method you just added.

![exit segue](exit-segue.png)



Unwind segues also allow you to jump over multiple screens or even multiple levels of navigation hierarchy. The system will automatically go backwards until it finds the screen which implements the method you specify. Try it with the push/pop flow:

* From the second view controller, push to a third view controller. On this third one, add a button which will do an unwind segue back to the dashboard (i.e. skipping the second view controller)

*/


/*:
## Passing data

* Add a UILabel to the `SecondViewController`, and also add a String property. On `viewDidLoad()`, you will populate the label's `text` with whatever is in this property.
* Make sure the segue between the first and second view controller has an identifer, e.g. segueToSecondPage
* Whenever a segue happens, the method `prepareForSegue` will get called. Override this method in the `FirstViewController` so that you can assign some data to the second view controller.


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? SecondViewController 
            where segue.identifier == "segueToSecondPage" {
            destinationVC.something = "foobar"
        }
    }

*/


/*:
## Integrate into main app

Change the main interface back to the Main.storyboard so our app loads normally again.

Add a storyboard reference to the Main.storyboard, and point it at the NavigationDemo.storyboard. This is how you can do segues from one storyboard to another, to keep your storyboards modular.

![storyboard.reference](storyboard.reference.png)

Use the screens on NavigationDemo.storyboard as the cards screen, by adding a Storyboard Reference, and doing a "view controller" segue to that from the Tab Bar controller

![navdemo.as.cards](navdemo.as.cards.png)

**Tip**

Due to the way iOS has implemented the storyboard reference, you will need to set the bar item properties on both the Main.storyboard (used at design time) and the NavigationDemo.storyboard (used at runtime)


*/

//: [Next](@next)

