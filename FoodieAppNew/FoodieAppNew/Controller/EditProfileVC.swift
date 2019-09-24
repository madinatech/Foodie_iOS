
import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: CommonTextfield!
    @IBOutlet weak var txtPhone: CommonTextfield!
    @IBOutlet weak var txtEmail: CommonTextfield!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnogout: UIButton!
    @IBOutlet weak var innerView: UIView!
    
    class func initViewController() -> EditProfileVC {
        let vc = EditProfileVC.init(nibName: "EditProfileVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        btnSave.isEnabled = false
        btnSave.alpha = 0.5
        btnogout.layer.borderColor = appPurpleColor.cgColor
        btnogout.layer.borderWidth = 1
        sowData()
    }
    
    func sowData ()  {
        let user : VerifyUser = VerifyUser.getUserByNumber(number: AccountManager.instance().activeAccount?.mobileNumber ?? "")
        lblName.text = user.name
        txtName.text = user.name
        txtEmail.text = user.email
        txtPhone.text = user.phone
    }
    
    @IBAction func saveClicked(_ sender: Any) {
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure want to logout?",         preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: .default,
                                      handler: {(_: UIAlertAction!) in
                                        appDelegateShared!.userLogout()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textChanged(_ sender: Any) {
        btnSave.isEnabled = true
         btnSave.alpha = 1.0
    }
    
}
