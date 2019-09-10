

import UIKit

class AccountVC: BaseViewController {
    
    @IBOutlet weak var txtFName: CommonTextfield!
    @IBOutlet weak var txtLName: CommonTextfield!
    @IBOutlet weak var txtemail: CommonTextfield!
    @IBOutlet weak var txtMobile: CommonTextfield!
    @IBOutlet weak var btnAddressBook: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    
    class func initViewController() -> AccountVC {
        let vc = AccountVC.init(nibName: "AccountVC", bundle: nil)
        vc.title = "Account"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func changePasswordClicked(_ sender: UIButton) {
        let vc = ChangePasswodVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addressbookClicked(_ sender: UIButton) {
    }
    
    @IBAction func editClicked(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
            disableFields()
        } else {
            sender.isSelected = true
            enablealFields()
        }
    }
    
    func enablealFields ()  {
        txtFName.isUserInteractionEnabled = true
        txtLName.isUserInteractionEnabled = true
        txtemail.isUserInteractionEnabled = true
        txtMobile.isUserInteractionEnabled = true
        btnAddressBook.isHidden = true
        btnChangePassword.isHidden = true
    }
    
    func disableFields ()  {
        txtFName.isUserInteractionEnabled = false
        txtLName.isUserInteractionEnabled = false
        txtemail.isUserInteractionEnabled = false
        txtMobile.isUserInteractionEnabled = false
        btnAddressBook.isHidden = false
        btnChangePassword.isHidden = false
    }
}
