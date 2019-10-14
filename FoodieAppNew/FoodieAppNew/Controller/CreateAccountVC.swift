
import UIKit
import NVActivityIndicatorView

class CreateAccountVC: UIViewController, UIScrollViewDelegate, NVActivityIndicatorViewable, UITextFieldDelegate, InternetDelegate {
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var txt1: CommonTextfield!
    @IBOutlet weak var txt2: CommonTextfield!
    @IBOutlet weak var txt3: CommonTextfield!
    @IBOutlet weak var txt4: CommonTextfield!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtName: CommonTextfield!
    @IBOutlet weak var txtEmail: CommonTextfield!
    
    var account = Account()
    class func initViewController(account : Account) -> CreateAccountVC {
        let vc = CreateAccountVC.init(nibName: "CreateAccountVC", bundle: nil)
        vc.account = account
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txt1.becomeFirstResponder()
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 25), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 220), animated: true)
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func proceedClicked(_ sender: Any) {
        var strMessage = ""
        let str1 = txt1.text!.trimmingCharacters(in: .whitespaces)
        let str2 = txt2.text!.trimmingCharacters(in: .whitespaces)
        let str3 = txt3.text!.trimmingCharacters(in: .whitespaces)
        let str4 = txt4.text!.trimmingCharacters(in: .whitespaces)
        let strName = txtName.text!.trimmingCharacters(in: .whitespaces)
        let strEmail = txtEmail.text!.trimmingCharacters(in: .whitespaces)
        
        if(str1.count <= 0 || str2.count <= 0 || str3.count <= 0 || str4.count <= 0){
            strMessage = "Please enter OTP"
        } else if(strName.count <= 0){
            strMessage = "Please enter name"
        } else if(strEmail.count <= 0){
            strMessage = "Please enter email id"
        } else if(!Utils.isEmail(txt: strEmail)){
            strMessage = "Please enter valid email id"
        }
        
        if(strMessage.count > 0){
            Utils.showAlert(withMessage: strMessage)
            return
        }
        verifyOtpApiCall()
    }
    func verifyOtpApiCall()  {
        let str1 = txt1.text!.trimmingCharacters(in: .whitespaces)
        let str2 = txt2.text!.trimmingCharacters(in: .whitespaces)
        let str3 = txt3.text!.trimmingCharacters(in: .whitespaces)
        let str4 = txt4.text!.trimmingCharacters(in: .whitespaces)
        let code : String = str1 + str2 + str3
        self.startAnimating()
        Manager.sharedManager().verifyNewUser(mobileNumber: "0\(account.mobileNumber.dropFirst(3))", code: code + str4, name: txtName.text ?? "", email: txtEmail.text ?? "") { (response, errorMessage) -> (Void) in
            self.stopAnimating()
            if(errorMessage.count > 0){
                if(errorMessage.contains("Internet")){
                    self.openNoInternetView()
                } else {
                    Utils.showAlert(withMessage: errorMessage)
                    return
                }
            }
            AccountManager.instance().activeAccount = self.account
            appDelegateShared?.showTabbar()
        }
    }
    
    func openNoInternetView()  {
        let vc = InternetVc.initViewController()
        vc.delegate = self
        self.navigationController?.present(vc, animated: false, completion: nil)
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
                //                txt4.becomeFirstResponder()
                view.endEditing(true)
            default:
                break
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func retryClicked() {
        verifyOtpApiCall()
    }
}
