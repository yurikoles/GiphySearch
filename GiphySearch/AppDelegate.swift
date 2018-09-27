//
//  AppDelegate.swift
//  GiphySearch
//
//  Created by Yurii Kolesnykov on 2018-09-27.
//  Copyright © 2018 yurikoles. All rights reserved.
//

import UIKit
import GiphyCoreSDK

fileprivate let giphyKey = "DaBfesbOSG7qDcYOME8kgb2QV9JhD0IW"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var appCoordinator: AppCoordinator?
    
    func configureAppCoordinator() {
        window = UIWindow()
        guard let window = window
        else {
            fatalError("no window!")
        }
        
        appCoordinator = AppCoordinator(window: window)
    }
    
    func configureGiphySDK () {
        GiphyCore.configure(apiKey: giphyKey)
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureGiphySDK()
        configureAppCoordinator()
        return true
    }
}
