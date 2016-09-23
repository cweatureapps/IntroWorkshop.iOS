//: [Previous](@previous)
import UIKit
/*: 
 ## Selectors

 Selectors are used to identify a function or method,
 "used to select a method to execute for an object".
 
 Selectors are generally only used with Objective-C APIs.

 For this to work, the class must derive from NSObject,
 and it must be exposed to the Objective-C runtime using `@objc`.

 (You can expose all members using `@objcMembers` on the class)

 */
@objc class Greetings: NSObject {
    @objc func helloWorld() {
    }
    @objc func sayHello(message: String) {
    }
}

#selector(Greetings.helloWorld)
#selector(Greetings.sayHello(message:))

/*:
 ### UIKit example

 Programmatically adding a handler to a control.
*/
class MyViewController: UIViewController {

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        button.addTarget(self, action: #selector(MyViewController.buttonHandler(sender:)), for: .touchUpInside)
    }

    @objc func buttonHandler(sender: Any?) {
        print("button tapped")
    }
}

/*:
 Under the hood, `@IBAction` use the same mechanism to identify the action.
 
 When you drag an `@IBAction` from the storyboard or view, and it creates a function:
 
     @IBAction func buttonTapped(_ sender: Any) {
     }


 In the storyboard source XML, it looks something like this:

```
<action selector="buttonTapped:" destination="BYZ-38-t0r" eventType="touchUpInside" id="v3d-g2-l1j"/>
```

 */

//: [Next](@next)
