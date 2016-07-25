import UIKit

//: # Session 6.1

/*:
## UIScrollView with AutoLayout

Setup the screen to use a UIScrollView, using AutoLayout.

1. Start a new storyboard, called ScrollViewDemo.storyboard
2. In a new view controller, add a Scroll View. Make it the full size of the screen (equal width/height with superview; center horizontally/vertically).
2. Add a view to the scrollview. This becomes the "Content View", and pin all 4 sides to the scrollview. These constraints are special, and are used by scrollview to work out contents area.
3. Often the contents view will have one axis equal to the main view's dimension.
   In our case, we are doing a vertical scroll, so make the width of the contents view equal to the top level view's width
4. Make sure the axis that scrolls (i.e. the one that is too long) will determine it's own intrinsic size, based on its children. E.g. on a vertical scroll, the height of the content view will be intrinsic to its children's height, so make sure you've joined up all the views from one end to the other.
5. That's it! Run this on a short device (e.g. iphone 4S) and see it scroll. (You can make this storyboard the main interface to just see this storyboard)
 
**Tip:**
 
You should set the content inset of the scrollview to take into account the status bar on top, and the navigation bar on the bottom. The best way to do this is programmatically in the view controller, as we have done in previous sessions. However, there is a hack (not recommended) that makes it work in the storyboard, which I'll do now (because I'm lazy).
 
![content-inset-hack](content-inset-hack.png)
 
*/



/*:

## UITextField

The UITextField is the way to allow users to input text from a keyboard.

Add a Text Field to the empty BPAY Scene in the Main view controller. (Not to be confused with the Text View, which displays multiple lines of text).
 
- note:
If the keyboard doesn't show up in the simulator, you can turn it on again from Hardware -> Keyboard -> Toggle software keyboard (⌘K)
 
Implement the following:

* Create a textfield with placeholder "description". Normal keyboard (no emoji).
* Underneath it, create a textfield with placeholder "amount". Numeric keypad to enter amounts (i.e. accepts decimal places)
* Textfields should have a clear (x) button
* When the screen first loads, focus on the description textfield.
* The return button for the description textfield should say "Next", and when you tap it, should focus on the amount textfield.
* Close any open keyboard when the view is tapped, by adding a tap gesture recognizer.
* Add validation logic to the textfield by using the delegate method `shouldChangeCharactersInRange`
    * For the description textfield, max length 20
    * For the amount textfield, prevent any non-numeric characters from being entered (e.g. typing via mac keyboard, or via pasting). Also make sure the amount is a valid amount.


**Hints:**
*/

// some useful methods related to focus

let textField = UITextField()
textField.becomeFirstResponder()
textField.resignFirstResponder()

let view = UIView()
view.endEditing(true)


// An easy way to work out what the new string will be
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

    let nsString = (textField.text ?? "") as NSString
    let newString = nsString.replacingCharacters(in: range, with: string)
    print(newString)

    return true
}



/*:

## UIKit User Interface Catalog
 
We don't have time to cover the other views and controls of UIKit. See the list here, and look for tutorials online: [UIKit User Interface Catalog](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/index.html)

(Note: Action Sheets and Alert Views are deprecated, but not reflected in the docs yet. We covered `UIAlertController`  in the previous session)

*/


//: [Next](@next)

