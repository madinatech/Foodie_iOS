

import UIKit

class ReferralsVC: BaseViewController {
    class func initViewController() -> ReferralsVC {
        let vc = ReferralsVC.init(nibName: "ReferralsVC", bundle: nil)
        vc.title = "Referrals"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
}
