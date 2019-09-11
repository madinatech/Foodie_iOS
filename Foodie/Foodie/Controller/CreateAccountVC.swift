
import UIKit

class CreateAccountVC: BaseViewController {
    
    @IBOutlet weak var txtLName: CommonTextfield!
    @IBOutlet weak var txtFName: CommonTextfield!
    
    @IBOutlet weak var txtEmail: CommonTextfield!
    
    @IBOutlet weak var txtPasssword: CommonTextfield!
    class func initViewController() -> CreateAccountVC {
        let vc = CreateAccountVC.init(nibName: "CreateAccountVC", bundle: nil)
        vc.title = "Login"
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

    @IBAction func fbClicked(_ sender: Any) {
    }
    
    @IBAction func showClicked(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
            txtPasssword.isSecureTextEntry = true
        } else {
            sender.isSelected = true
            txtPasssword.isSecureTextEntry = false
        }
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
    }
}
