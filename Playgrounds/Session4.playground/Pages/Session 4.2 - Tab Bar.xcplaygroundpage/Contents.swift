//: [Previous](@previous)

/*:
# Session 4.2

## Part A - Tab bar

![](session.4.2.png "session 4.2 design")


1. Select the navigation controller, and go Editor -> Embed in -> Tab bar controller
2. Set the bar item's Title and Image accordingly
 
![tabbaritem.title.image](tabbaritem.title.image.png "tabbaritem.title.image")

 
3. Add 3 more view controllers to the storyboard for the other 3 screens, and wire them up to the tab bar controller as a "view controllers" type of segue

![view.controller.relationship.segue](view.controller.relationship.segue.png "view.controller.relationship.segue")

4. Similar to what you did in step 2 for the first accounts tab, set each of the bar item's Title and Image accordingly for the 3 new tabs you just added.
5. Now to set some properties on the Tab Bar. To make the bar dark, select the Tab bar on the tab bar controller, and set the Style to "Black". To make the selected item into an orange tint, set the "Image Tint" to the correct orange color.
 

![tabbar.properties](tabbar.properties.png "tabbar.properties")

6. The image tint way above works for iOS 10. To make this work on earlier versions of iOS, you need to set the tint color of each bar item. Set the tintColor in the "User Defined Runtime Attributes" for each bar item.

![tabbaritem.tintcolor](tabbaritem.tintcolor.png "tabbaritem.tintcolor")

*/
/*:
 * callout(Tip):
 You can actually copy/paste the runtime attributes between different items
*/
//: [Next](@next)
