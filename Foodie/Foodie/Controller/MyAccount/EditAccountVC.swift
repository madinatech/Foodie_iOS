
import UIKit

@objc protocol EditAccountDelegate {
    func closeEditView()
    func updateAccount()
}

class EditAccountVC: UIViewController {
    
    @IBOutlet weak var txtMobile: CommonTextfield!
    @IBOutlet weak var txtEmail: CommonTextfield!
    
     var delegate :  EditAccountDelegate? = nil
    
    class func initViewController() -> EditAccountVC {
        let vc = EditAccountVC.init(nibName: "EditAccountVC", bundle: nil)
       
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMobile.becomeFirstResponder()
       
    }

    @IBAction func closeClicked(_ sender: Any) {
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.closeEditView()
            }
        }
    }
    @IBAction func updateClicked(_ sender: Any) {
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.updateAccount()
            }
        }
    }
}
