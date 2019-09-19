

import UIKit

class VerifyOTPVC: UIViewController {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var txt1: CommonTextfield!
    @IBOutlet weak var txt2: CommonTextfield!
    @IBOutlet weak var txt3: CommonTextfield!
    @IBOutlet weak var txt4: CommonTextfield!
    @IBOutlet weak var txt5: CommonTextfield!
    @IBOutlet weak var txt6: CommonTextfield!
    
    class func initViewController() -> VerifyOTPVC {
        let vc = VerifyOTPVC.init(nibName: "VerifyOTPVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
  
    @IBAction func textfieldChanged(_ sender: UITextField) {
        let text = sender.text
        
        if text?.utf16.count ?? 0 >= 1{
            switch sender{
            case txt1:
                txt2.becomeFirstResponder()
            case txt2:
                txt3.becomeFirstResponder()
            case txt3:
                txt4.becomeFirstResponder()
            case txt4:
                txt5.becomeFirstResponder()
            case txt5:
                txt6.becomeFirstResponder()
            case txt6:
                txt6.becomeFirstResponder()
            default:
                break
            }
        }
    }

}
