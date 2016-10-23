//
//  CustomTabBarController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 23/10/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    private enum Constants {
        static let tabBarHeight: CGFloat = 44
        static let tabBarItemOffset = UIEdgeInsetsMake(6, 0, -6, 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // reduce height of tab bar
        var tabFrame = tabBar.frame
        tabFrame.size.height = Constants.tabBarHeight
        tabFrame.origin.y = view.frame.height - Constants.tabBarHeight
        tabBar.frame = tabFrame

        // shift the tab bar items down
        tabBar.items?.forEach { tabBarItem in
            tabBarItem.imageInsets = Constants.tabBarItemOffset
        }
    }

}
