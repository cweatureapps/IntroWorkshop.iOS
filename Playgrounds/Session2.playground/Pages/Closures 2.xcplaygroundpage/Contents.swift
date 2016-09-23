//: [Previous](@previous)

import UIKit
import PlaygroundSupport

/*:
### Closure Exercise 2

1. Animate the box to the center
2. And then from the center, grow it to fill the canvas

Tips:
* Change to "manual run" by long click of the play button at the bottom of this screen
* Show the timeline liveView by opening assistant editor (2 circles button on top right)

*/

let canvas = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = canvas

var v = UIView(frame: CGRect(x: 30, y: 30, width: 50, height: 50))
v.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)
canvas.addSubview(v)

// Hint:
/*:
    UIView.animate(withDuration: 0.5, animations: {
        // change properties here
    }) { _ in 
        // do something when animation completes
    }
*/

// some useful UIView properties:
v.center
v.frame.size
v.frame.origin

//----------------------------------------

// solution

UIView.animate(withDuration: 0.5, animations: {
    v.center = canvas.center
}) { _ in  // use underscore when you dont need variable
    UIView.animate(withDuration: 0.5) {
        v.bounds.size.width = canvas.bounds.width
        v.bounds.size.height = canvas.bounds.height
    }
}


//: [Next](@next)
