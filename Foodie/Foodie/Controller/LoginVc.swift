

import UIKit

class LoginVc: BaseViewController {
    
    @IBOutlet weak var txtEmail: CommonTextfield!
    
    class func initViewController() -> LoginVc {
        let vc = LoginVc.init(nibName: "LoginVc", bundle: nil)
        vc.title = "Login"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func fbClicked(_ sender: Any) {
    }
    @IBAction func nextClicked(_ sender: Any) {
    }
    
    @IBAction func CreateAccountClicked(_ sender: Any) {
        let vc = CreateAccountVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
