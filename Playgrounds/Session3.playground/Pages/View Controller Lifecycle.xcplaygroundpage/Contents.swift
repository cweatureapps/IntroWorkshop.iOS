//: [Previous](@previous)
/*:
# View controller lifecycle

![view controller lifecycle](vc.lifecycle.png "view controller lifecycle")
 
### viewDidLoad
* outlets are ready to use
* good place to make service calls here
* geometry and layout is not yet ready - don’t do any visual calculations
* only called once

### viewWillAppear
* layout has not happened yet
* called just before the view is visible on screen
* called multiple times - will also be called whenever you come back to this screen from another screen

### viewWillLayoutSubviews
* layout is about to happen
* programmatically change constraints here as needed
* may be called multiple times (e.g. orientation change)

### viewDidLayoutSubviews
* layout has completed, frame/bounds values are correct
* may be called multiple times (e.g. orientation change)

### viewDidAppear
* view has been drawn on the screen
* when you want to do something after a short delay after the screen is visible
* called multiple times - will also be called whenever you come back to this screen from another screen

### viewWillDisappear
* view is about to be removed, but is still visible
* do clean up, which can be done while the screen is still visible (e.g. remove observers)

### viewDidDisappear
* view has been removed and is no longer visible
* do clean up, that you want to happen after the screen is gone (e.g. reset navigation)

*/
//: [Next](@next)
