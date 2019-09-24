
import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: CommonTextfield!
    @IBOutlet weak var txtPhone: CommonTextfield!
    @IBOutlet weak var txtEmail: CommonTextfield!
    @IBOutlet weak var btnSave: UIButton!
    
    
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
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
