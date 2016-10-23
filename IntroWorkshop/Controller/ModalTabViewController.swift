//
//  ModalTabViewController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 23/10/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

/// Specify this as the class of the view controller
/// which has the view controller relationship with a UITabBarController.
/// This acts as a placeholder model that the `CustomTabBarController` can use
/// to determine which view controller to present modally.
@IBDesignable class ModalTabViewController: UIViewController {

    /// Some unique identifier that can be used to create a view controller to present.
    @IBInspectable var identifier: String?
}
