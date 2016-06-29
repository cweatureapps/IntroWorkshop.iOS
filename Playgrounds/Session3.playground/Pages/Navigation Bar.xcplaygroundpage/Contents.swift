//: [Previous](@previous)

/*:
 
## Transparent nav bar

In the storyboard, embed the view controller in a navigation controller. (Editor -> Embed in -> Navigation controller)
 
Notice how the navigation controller is the initial view controller now.
 
Look for **Bar Button Item** and drag it onto the navigation bar. In the properties, remove the text, set the image, and set the tint. Do this for both the left button and the right button.

Watch the demo here:

 ![navigation bar demo](session3.nav.mp4 "navigation bar demo")
 


Finally, in the view controller, call the following code in `viewDidLoad()` to make the navigation bar transparent.


    private func setupNavBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }


 
*/

