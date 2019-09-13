
import UIKit
import CoreData
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        IQKeyboardManager.shared.enable = true
         GMSServices.provideAPIKey(GoogleApiKey)
        GMSPlacesClient.provideAPIKey(GoogleApiKey)
        Thread.sleep(forTimeInterval: 2.0)
        
        let controller  = DeliveryLoactionVC.initViewController()
        self.navigationController = UINavigationController.init(rootViewController: controller)
        setNavigationBarColor()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    func setNavigationBarColor() {
        UINavigationBar.appearance().barTintColor =  UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Calibri-Bold", size: 20) ?? ""]
        self.navigationController.navigationBar.isTranslucent = false
    }
    
    func showTabbar(){
        let controller : BaseTabBarController = BaseTabBarController.initViewController()
        self.navigationController = UINavigationController.init(rootViewController: controller)
        self.navigationController.isNavigationBarHidden = true
        //        window?.rootViewController = navigationController
        //        window?.makeKeyAndVisible()
        var options = UIWindow.TransitionOptions()
        options.direction = .toRight
        window?.setRootViewController(navigationController, options: options)
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
        let container = NSPersistentContainer(name: "Foodie")
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

