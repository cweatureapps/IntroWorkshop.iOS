/*:

# Session 3

Implementing a read-only UI

![Visual specs 1](session3.design.png "Visual design")

![Visual specs 2](session3.markup.png "Visual design markup")


## Part 1

In the first half of this session, we implement a screen that shows the account details.

**Topics**

* Asset catalogs, template images, tint
* UIView, UIImageView, UILabel
* Autolayout
* Include currency formatting logic in the model - `NumberFormatter`
* ViewController lifecycle

 
### Asset catalog
 
Images have been provided in the `Assets` folder. (These are typically given to you by the visual designer). Open up the asset catalog in the project `Assets.xcassets` and drag those images from finder into the catalog. You'll notice that the catalog recognizes the different resolution images.
 

### Storyboard

Open up `Main.storyboard`. This editor is called to as **Interface builder**. You'll see a view controller. This will be your first screen. We'll start creating the user interface now.

Remember to set your view controller as the entrypoint for the Main storyboard, otherwise the system doesn't know which is your first screen!

 ![initial view controller](initial.view.controller.png "initial view controller")


### UIImageView

We'll add the background image now. To add objects, use the object library in the bottom right. Search for **UIImageView** and drag that onto the view controller.

![Adding UIImage](uiimage.png "Adding UIImage")

In the properties, specify the name of the image to use, and specify the content mode of **Aspect Fill**

![image properties](image.properties.png "image properties")

### AutoLayout Constraints
 
AutoLayout constraints are all about setting up relationships with other views. To set up a relationship between two views, you *ctrl-drag* from one view to another.
 
The constraints will need to provide enough information so that the system can work out where a view goes. This means it will need to be able to infer:
* x-position
* y-position
* width
* height


Make the image take up the full size of the screen by setting up constraints with the superview (referred to as the ***container***).
Ctrl-drag from the image to the top level view, and add constraints for equal width, equal height, center horizontally, center vertically.
 
See demo here:
 
 ![bg_sunset_constraints](bg_sunset_constraints.mp4 "bg_sunset_constraints")


*/
/*:
 * callout(Tip):
 Hold down the **shift** key to select multiple constraints.
 Hold down the **option** key to pick alternative options for constraints.
*/
/*:

### UIView

Everything that draws on screen in `UIKit` is a subclass of `UIView`. You can use this object directly if you want to group views together. We'll add a view now that will become our account details view.

1. Search for a `UIView` in the object library and drag that in.
2. Ctrl-drag to top level view to add constraints of leading, trailing, and vertical spacing to top layout guide.
3. Ctrl-drag to itself to add a fixed height constraint
4. Modify the constraints in the size inspector properties on the right to set up the exact measurements

 
### UILabel
 
The `UILabel` is the object to use to display some read-only text.
 
Add labels for all the text which is inside the account details view.
 
Follow the visual design and set up AutoLayout constraints to define where the labels will be on the screen.

Also use the attributes inspector properties to set the font size and text color.
 
### Template image
 
Add a `UIImage` to the account details view for the wallet icon and set up the AutoLayout constraints.
 
iOS allows us to tint icons, so that the visual designer only needs to provide a single asset, and we can change the color.

In order for tint to work, you make sure image is set to "Render as Template Image" in the asset catalog.

![Render as Template Image](render.as.template.png "Render as Template Image")


`UIImageView` also has bugs where the tint doesn't always work when set via the "Tint" property. Set it in the "User defined runtime attributes" instead.


![UIImageView tintColor bug](uiimageview.tintcolor.bug.png "UIImageView tintColor bug")


### Dark Background
 
You may have tried to implement the black 0.5 opacity background by giving the view a black background, and setting the alpha to 0.5.
 
What happens if you do that?

To implement the background properly, create another `UIView` inside the account details view, making it the same size as the account details view, and this is the one you want to give a black background with alpha of 0.5.



### ViewController

Create a new view controller file `AccountsViewController.swift`. 
 

    class AccountsViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    }


In the storyboard identity inspector, set the custom class to `AccountsViewController`. You'll notice the module is updated for you automatically.
 

![custom class](custom.class.png "custom class")

### IBOutlet
 
`IBOutlet` is how you programmatically access the objects created from interface builder documents.
 
When the storyboard is open, click on the assistant editor button (top right, the 2 circles) to open up the view controller on the right.
 
Ctrl-drag an object from the storyboard into the code. This will create an `IBOutlet`, which is a reference that you can use in your code. This is wired up for you during the view controller lifecycle, and is ready by the time `viewDidLoad` is called.

Now, create outlets for all the `UILabel`.
 


### Integrate with service
 
You've already learnt how to call the service (code is in the unit tests).
You've just learnt how you can reference the `UILabel` objects programmatically.
Now, integrate with the service, and set the correct value for the labels programmtically after calling the service.



### Number formatter

This is an example of how to create an `NSNumberFormatter`

    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    formatter.locale = Locale(identifier: "en_AU")

This object is considered expensive to create, so you can cache it and reuse it by making it a static var:

    private static var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_AU")
        return formatter
    }()

Add a couple of "view model" properties to the `Account` model, e.g. `formattedAvailableFunds` and `formattedAccountBalance`, and use the above formatter to do the formatting.

*/
/*:
 * callout(Tip):
 One approach to add "view model" properties is to use an extension.
 In our iOS foundation frameworks, the model is in a reusable framework, 
 and would contain logic shared by all apps.
 But this type of formatting logic would often be app specific.
 So you would extend the `Account` object, and add some properties to it.
*/

/*:
## All done!

Congrats on finishing part 1!!! 👍😎

Your screen should now look something like this:
 
![done](done.png "done")

*/

//: [Next](@next)
