//: [Previous](@previous)
/*:
 # UIView lifecycle

 ![UIViewLifecycle](UIViewLifecycle.png "UIViewLifecycle")

 ### initWithCoder
 * object is created from the XML
 
 ### awakeAfterUsingCoder
 * "substitute another object in place of the object that was decoded"
 * Most common use case for this is to swap out some view in the storyboard for another reusable view you've defined in another Xib
 
 ### willMoveToSuperview / didMoveToSuperview
 * Called when the superview changes
 * If you need to do something at the point where the view is added/removed to/from the view heirarchy
 * E.g. I've used this when I had to add/remove some additional sibling views for our custom text field control

 ### awakeFromNib
 * Called after object has been loaded from Xib
 * Override this to perform any initialization you need. IBOutlets are ready at this point.
 * You often override this to set default values or clear out dummy (design time) values
 
 ### layoutSubviews
 * Called to perform the layout
 * Most common time to override this is to programmatically set constraints, then call `super.layoutSubviews()`

*/
//: [Next](@next)
