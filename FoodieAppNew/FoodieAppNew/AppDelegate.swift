//
//  AppDelegate.swift
//  FoodieAppNew
//
//  Created by CrossGrids on 17/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import AlamofireNetworkActivityLogger
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        IQKeyboardManager.shared.enable = true
        Thread.sleep(forTimeInterval: 2.0)
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        setupCoredata()
        if(AccountManager.instance().activeAccount == nil){
            if(UserDefaults.standard.object(forKey: Selected_Area) == nil){
                let vc = DeliveryLoactionVC.initViewController()
                let nav = UINavigationController.init(rootViewController: vc)
                window?.rootViewController = nav
                window?.makeKeyAndVisible()
            } else {
                showTabbar()
            }
        } else {
            showTabbar()
        }
        return true
    }
    
    func setupCoredata(){
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "FoodieAppNew.sqlite")
        let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print("path  = \(paths)")
    }
    
    func showLogin () {
        let controller : LoginVC = LoginVC.initViewController()
        self.navigationController = UINavigationController.init(rootViewController: controller)
        self.navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func userLogout () {
        clearDatabase()
        AccountManager.instance().activeAccount = nil
        showTabbar()
    }
    
    func showTabbar(){
        let controller : BaseTabViewController = BaseTabViewController.initViewController()
        self.navigationController = UINavigationController.init(rootViewController: controller)
        self.navigationController.isNavigationBarHidden = true
        //        window?.rootViewController = navigationController
        //        window?.makeKeyAndVisible()
        var options = UIWindow.TransitionOptions()
        options.direction = .toRight
        window?.setRootViewController(navigationController, options: options)
    }
    
    func clearDatabase (){
        MagicalRecord.save(blockAndWait: { (localContext:NSManagedObjectContext) in
            VerifyUser.mr_truncateAll(in: localContext)
            AppExpires.mr_truncateAll(in: localContext)
            UserData.mr_truncateAll(in: localContext)
            DeliveryOption.mr_truncateAll(in: localContext)
            PaymentOption.mr_truncateAll(in: localContext)
            Address.mr_truncateAll(in: localContext)
        })
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FoodieAppNew")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension UIApplication{
    var statusbarView : UIView?{
        return value(forKey: "statusBar") as? UIView
    }
}
