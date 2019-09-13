
import UIKit

class CreateAccountVC: BaseViewController {
    
    @IBOutlet weak var txtName: CommonTextfield!
    @IBOutlet weak var txtMobile: CommonTextfield!
    @IBOutlet weak var txtEmail: CommonTextfield!
 
    
    class func initViewController() -> CreateAccountVC {
        let vc = CreateAccountVC.init(nibName: "CreateAccountVC", bundle: nil)
        vc.title = "Create Account"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
    }
    

    
    @IBAction func termsClicked(_ sender: Any) {
        let vc = TermsVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func termsandConditionClicked(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @IBAction func newsLetterCLicked(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        let vc = VerifyOtpVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
