//
//  AppDelegate.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?
    private var context: Context!
    private var coordinator: AppCoordinator!

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        context = Context.build()
        coordinator = AppCoordinator(appDelegate: self,
                                     context: context)
        coordinator.start()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        context.dataBaseStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        context.dataBaseStack.saveContext()
    }

}
