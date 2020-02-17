//
//  AppDelegate.swift
//  AppStoreSearch
//
//  Created by N17430 on 14/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let appComponent = AppComponent(application: application, launchOptions: launchOptions)
        let rib = RootBuilder(dependency: appComponent).build()
        self.launchRouter = rib
        launchRouter?.launchFromWindow(window)
        

        return true
    }
    
    // MARK: - Private

    private var launchRouter: LaunchRouting?
    
}

