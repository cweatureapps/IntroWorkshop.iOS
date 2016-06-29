/*:

# Session 3

Implementing a read-only UI

![Visual specs 1](session3.design.png "Visual design")

![Visual specs 2](session3.markup.png "Visual design markup")


## Part 1

In the first half of this session, we implement a screen that shows the account details.

**Topics**

* Asset catalogs, template images, tint
* UIImageView
* UILabel
* Autolayout
* ViewController lifecycle
* Include currency formatting logic in the model - `NSNumberFormatter`


### Tips

Remember to set your view controller as the entrypoint for the Main storyboard, otherwise the system doesn't know which is your first screen!

![initial view controller](initial.view.controller.png "initial view controller")


In order for tint to work, make sure image is set to "Render as Template Image"

![Render as Template Image](render.as.template.png "Render as Template Image")


`UIImageView` also has bugs where the tint doesn't always work when set via the "Tint" property. Set it in the "User defined runtime attributes" instead.


![UIImageView tintColor bug](uiimageview.tintcolor.bug.png "UIImageView tintColor bug")


Call the following code in `viewDidLoad()` to make the navigation bar transparent.


    private func setupNavBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navBar.shadowImage = UIImage()
        navBar.translucent = true
    }


## Part 2

In the second half of this session, we refactor the view into `AccountDetailsView`,
so that we can reuse this tile for every account, and also on the drilldown transaction details screen.


**Topics**

* UIView and Xib
* UIView lifecycle
* Adding designer support (Demo)




*/
