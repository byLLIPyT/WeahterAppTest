//
//  AppDelegate.swift
//  WeahterAppTest
//
//  Created by Александр Уткин on 05.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationVC: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.navigationVC = UINavigationController.init(rootViewController: TableViewController())
        window?.rootViewController = self.navigationVC
        window?.makeKeyAndVisible()
        return true
    }
    
}

