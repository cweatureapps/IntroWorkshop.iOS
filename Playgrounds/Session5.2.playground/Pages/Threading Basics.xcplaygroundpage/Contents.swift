import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
By default, code for your app is executed in the "main queue", which executes tasks on the main thread, which is the only thread which is allowed to update the UI. If you lock up this main thread with a long running operation, then the UI becomes responsive. This means you should be mindful of the following:
 
* Don't run time consuming tasks on the main queue. If you have a long running operation, do it on another queue asynchronously, allowing the UI to stay responsive
* When the async call completes, make sure any UI updates you do are on the main thread again, otherwise, the UI won't update at the right time.
 
*/


//: ### Grand Central Dispatch (GCD)

/*
// Swift 2 syntax
dispatch_async(dispatch_get_main_queue()) {
    // do something async
}
*/

print("1")

// Swift 3 syntax
DispatchQueue.main.async {
    print("do something async")
}

print("2")

/*
// Swift 2 syntax
let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC)))
dispatch_after(delay, dispatch_get_main_queue()) {
    // do something after a delay
}
*/

// Swift 3 syntax
DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
    print("do something after a delay")
}

// getting a different queue
/*
// Swift 2 syntax
let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
dispatch_async(queue) {
    // do something async on a different queue
}
*/

DispatchQueue.global(qos: .background).async {
    print("do something on background queue")
}

/*:
 The different QoS classes:

 * [https://developer.apple.com/reference/dispatch/dispatchqos.qosclass]()

Swift 2 Tutorial

* [https://www.raywenderlich.com/79149/grand-central-dispatch-tutorial-swift-part-1]()
 
 
Swift 3 Tutorials
 
* [https://swiftable.io/2016/06/dispatch-queues-swift-3/]()
* [https://medium.com/swift-and-ios-writing/a-quick-look-at-gcd-and-swift-3-732bef6e1838]()

*/

//: [Next](@next)
