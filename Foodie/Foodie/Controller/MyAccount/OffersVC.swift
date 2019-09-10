

import UIKit

class OffersVC: BaseViewController {
    
    class func initViewController() -> OffersVC {
        let vc = OffersVC.init(nibName: "OffersVC", bundle: nil)
        vc.title = "Offers"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    
}
