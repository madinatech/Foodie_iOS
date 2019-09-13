

import UIKit


class VerifyOtpVC: BaseViewController {
    
    @IBOutlet weak var txt1: CommonTextfield!
    @IBOutlet weak var txt2: CommonTextfield!
    @IBOutlet weak var txt3: CommonTextfield!
    @IBOutlet weak var txt4: CommonTextfield!
    @IBOutlet weak var txt5: CommonTextfield!
    @IBOutlet weak var txt6: CommonTextfield!
    
    
    class func initViewController() -> VerifyOtpVC {
        let vc = VerifyOtpVC.init(nibName: "VerifyOtpVC", bundle: nil)
     vc.title = "Verification"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txt1.becomeFirstResponder()
        
    }
    
    
    @IBAction func verifyClicked(_ sender: Any) {
        appDelegateShared?.showTabbar()
//        let strPasscode1 = txt1.text!.trimmingCharacters(in: .whitespaces)
//        let strPasscode2 = txt2.text!.trimmingCharacters(in: .whitespaces)
//        let strPasscode3 = txt3.text!.trimmingCharacters(in: .whitespaces)
//        let strPasscode4 = txt4.text!.trimmingCharacters(in: .whitespaces)
//         let strPasscode5 = txt5.text!.trimmingCharacters(in: .whitespaces)
//         let strPasscode6 = txt6.text!.trimmingCharacters(in: .whitespaces)
//
//        if(strPasscode1.count <= 0 && strPasscode2.count <= 0 && strPasscode3.count <= 0 && strPasscode4.count <= 0 && strPasscode5.count <= 0 && strPasscode6.count <= 0){
//            Utils.showAlert(withMessage: "Please enter OTP")
//            return
//        }
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
                txt6.resignFirstResponder()
            default:
                break
            }
        }
    }
}
