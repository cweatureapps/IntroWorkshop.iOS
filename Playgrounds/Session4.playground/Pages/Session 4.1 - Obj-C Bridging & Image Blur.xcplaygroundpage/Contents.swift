//: [Previous](@previous)

/*:
# Session 4.1B

### Including Objective-C code in a Swift project

iOS apps have been written in Objective-C for many years, so you'll often need to include 3rd party code or legacy code in your project which were written in Objective-C.

`UIImageEffects` is a class released by Apple which allows you to apply blur and tint effects to an image.
It is written in Objective-C, but don't worry - Swift and Objective-C work very well together within the same project.

1. In the **Supporting Files** folder, add a new Objective-C file. Name it anything you want, and make it an **Empty file**
2. Xcode will offer to create a bridging header for you. Create the bridging heading. It will be created in that directory.
3. Delete the Objective-C file, you don't need it anymore.
4. Include `UIImageEffects.h` and `UIImageEffects.m` into the project, in the View folder. (These files are already included in the View folder on disk, and just need to be included in the project)
5. Include the following line in the bridging header. This is how you expose Objective-C code to Swift.


    #import "UIImageEffects.h"

6. Build the project. You should now be able to access this class in Swift


### Blurring an image

Create an outlet to the background image UIImageView so you can reference it from your view controller.
You can get the `UIImage` from this using the `image` property.
Then pass the image to the `UIImageEffects.imageByApplyingBlur` function, using the following parameters:

* radius: 40
* tintColor: UIColor.clear
* saturationDeltaFactor: 1.2

You can experiment with different settings to see the effect.

 
    private func blurImage() {
        let blurImage = UIImageEffects.imageByApplyingBlur(to: backgroundImageView.image, withRadius: 40, tintColor: UIColor.clear, saturationDeltaFactor: 1.2, maskImage: nil)
        backgroundImageView.image = blurImage
    }

For further reading, have a look at the following tutorials

* [http://code.tutsplus.com/tutorials/adding-blur-effects-on-ios--cms-21488](http://code.tutsplus.com/tutorials/adding-blur-effects-on-ios--cms-21488)
* [https://www.raywenderlich.com/84043/ios-8-visual-effects-tutorial](https://www.raywenderlich.com/84043/ios-8-visual-effects-tutorial)

*/

//: [Next](@next)
