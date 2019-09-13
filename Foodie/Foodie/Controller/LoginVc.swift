

import UIKit

class LoginVc: BaseViewController {
    
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var loginView: UIView!
    
    class func initViewController() -> LoginVc {
        let vc = LoginVc.init(nibName: "LoginVc", bundle: nil)
        vc.title = "Login"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        isBackButtonHidden = true
        loginView.dropShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
    }
    
    @IBAction func loginclicked(_ sender: Any) {
        let vc = VerifyOtpVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createaccountClicked(_ sender: Any) {
        let vc = CreateAccountVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
