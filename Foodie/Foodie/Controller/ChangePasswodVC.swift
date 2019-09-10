

import UIKit

class ChangePasswodVC: BaseViewController {
    
    @IBOutlet weak var txtConfirmPassword: CommonTextfield!
    @IBOutlet weak var txtNewPassword: CommonTextfield!
    @IBOutlet weak var txtCurrentPassword: CommonTextfield!
    
    class func initViewController() -> ChangePasswodVC {
        let vc = ChangePasswodVC.init(nibName: "ChangePasswodVC", bundle: nil)
        vc.title = "Change Password"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func saveClicked(_ sender: Any) {
    }
    
    @IBAction func showNewPassword(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
            txtNewPassword.isSecureTextEntry = true
        } else {
            sender.isSelected = true
            txtNewPassword.isSecureTextEntry = false
        }
    }
    @IBAction func showConfirmPassword(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
            txtConfirmPassword.isSecureTextEntry = true
        } else {
            sender.isSelected = true
            txtConfirmPassword.isSecureTextEntry = false
        }
    }
    
    @IBAction func showCurrentPassword(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
            txtCurrentPassword.isSecureTextEntry = true
        } else {
            sender.isSelected = true
            txtCurrentPassword.isSecureTextEntry = false
        }
    }
}
