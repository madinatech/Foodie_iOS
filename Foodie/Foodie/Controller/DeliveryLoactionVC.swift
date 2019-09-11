
import UIKit

class DeliveryLoactionVC: BaseViewController {
    
    class func initViewController() -> DeliveryLoactionVC {
        let vc = DeliveryLoactionVC.init(nibName: "DeliveryLoactionVC", bundle: nil)
        vc.title = "Delivery Location"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
//        self.isBackButtonHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
    }

    @IBAction func currentLocationClicked(_ sender: Any) {
    }
    
    @IBAction func areaClicked(_ sender: Any) {
        let vc = AreaVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func seeAllVendors(_ sender: Any) {
        appDelegateShared?.showTabbar()
//        let vc = RestaurantsVC.initViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func cityClicked(_ sender: Any) {
        let vc = CityVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
