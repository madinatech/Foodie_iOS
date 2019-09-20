
import UIKit
import CBFlashyTabBarController

class BaseTabViewController: CBFlashyTabBarController, UITabBarControllerDelegate  {
    
    class func initViewController() -> BaseTabViewController {
        let controller = BaseTabViewController.init(nibName: "BaseTabViewController", bundle: nil)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    
    
    @objc func setViews() {
        
        self.tabBar.tintColor = appThemeColor
        self.tabBar.unselectedItemTintColor = UIColor.black
        self.tabBar.barTintColor = UIColor.white
        UITabBar.appearance().isTranslucent = true
        //         UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Calibri", size: 14) ?? ""], for: .normal)
        
        
        let v1 = HomeVC.initViewController()
        v1.tabBarItem.image = UIImage(named: "Home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        v1.tabBarItem.title = "Home"
        let v2 = SearchVC.initViewController()
        v2.tabBarItem.image = UIImage(named: "Search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        v2.tabBarItem.title = "Search"
        let v3 = OrderListVC.initViewController()
        v3.tabBarItem.image = UIImage(named: "Cart")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        v3.tabBarItem.title = "Orders"
        
        if(AccountManager.instance().activeAccount != nil){
            let v4 = UserProfileVc.initViewController()
            v4.tabBarItem.image = UIImage(named: "User")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            v4.tabBarItem.title = "Profile"
            self.viewControllers = [v1, v2, v3, v4]
        } else {
            let v4 = LoginVC.initViewController()
            v4.tabBarItem.image = UIImage(named: "User")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            v4.tabBarItem.title = "Login"
            self.viewControllers = [v1, v2, v3, v4]
        }
    }
    
    
}
