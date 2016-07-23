//
//  SettingsManager.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 24/07/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

class SettingsManager {
    class func registerSettingsFromBundle() {
        let settingsPath = Bundle.main.path(forResource: "Settings", ofType: "bundle")!
        let rootPlistPath = (settingsPath as NSString).appendingPathComponent("Root.plist")
        let rootSettings = NSDictionary(contentsOfFile: rootPlistPath)!
        var defaultsToRegister = [String: AnyObject]()
        if let preferences = rootSettings["PreferenceSpecifiers"] as? [AnyObject] {
            for p in preferences {
                guard let p = p as? [String: AnyObject],
                    let key = p["Key"] as? String,
                    let defaultValue = p["DefaultValue"] else { continue }
                defaultsToRegister[key] = defaultValue
            }
        }
        UserDefaults.standard.register(defaults: defaultsToRegister)
        UserDefaults.standard.synchronize()
    }
}
