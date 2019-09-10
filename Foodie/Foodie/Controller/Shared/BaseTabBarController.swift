
import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    class func initViewController() -> BaseTabBarController {
        let controller = BaseTabBarController.init(nibName: "BaseTabBarController", bundle: nil)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setViews()
    }

    @objc func setViews ()  {
        self.tabBar.tintColor =  UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: 1.0)
        self.tabBar.unselectedItemTintColor = UIColor.darkGray
        self.tabBar.barTintColor = UIColor.white
         UITabBar.appearance().isTranslucent = true
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 12) ?? ""], for: .normal)
        
        let v1 = RestaurantsVC.initViewController()//DeliveryLoactionVC.initViewController()
        let v2 = SearchVC.initViewController()
        let v3 = CartVC.initViewController(isFromRestaurant: false)
        let v4 = MyAccountViewController.initViewController()

        
        let myTabBarItem1 = UITabBarItem()
        myTabBarItem1.tag = 0
//        myTabBarItem1.image = UIImage(named: "patient")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        myTabBarItem1.selectedImage = UIImage(named: "patient_s")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        myTabBarItem1.title = "Restaurants"
        v1.tabBarItem = myTabBarItem1
        
        let myTabBarItem2 = UITabBarItem()
        myTabBarItem2.tag = 1
        myTabBarItem2.image = UIImage(named: "Search_un")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "Search_sel")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.title = "Search"
        v2.tabBarItem = myTabBarItem2
        
        let myTabBarItem3 = UITabBarItem()
        myTabBarItem3.tag = 2
        myTabBarItem3.image = UIImage(named: "Cart_un")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "Cart_sel")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.title = "Cart"
        v3.tabBarItem = myTabBarItem3
        
        let myTabBarItem4 = UITabBarItem()
        myTabBarItem4.tag = 3
        myTabBarItem4.image = UIImage(named: "user_un")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.selectedImage = UIImage(named: "user_sel")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.title = "Account"
        v4.tabBarItem = myTabBarItem4
        
        
        let nav1 = UINavigationController.init(rootViewController: v1)
        let nav2 = UINavigationController.init(rootViewController: v2)
        let nav3 = UINavigationController.init(rootViewController: v3)
        let nav4 = UINavigationController.init(rootViewController: v4)
        
//        setNavBar(nav: nav1)
//        setNavBar(nav: nav2)
//        setNavBar(nav: nav3)
//        setNavBar(nav: nav4)
        
        let controllers = [nav1, nav2, nav3, nav4]
        self.viewControllers = controllers
        self.selectedViewController = nav1
        
//        if selectedViewController == nav2{
//            Utils.setBoolForKey(false, key: "FromAddAppointment")
//        }
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 60
        tabFrame.origin.y = self.view.frame.height - 60
        self.tabBar.frame = tabFrame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}