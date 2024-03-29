
import UIKit
import NVActivityIndicatorView

class LoginVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, NVActivityIndicatorViewable, InternetDelegate {
    
    @IBOutlet weak var txtMobile: CommonTextfield!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    class func initViewController() -> LoginVC {
        let vc = LoginVC.init(nibName: "LoginVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        txtMobile.text = "753443398"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        txtMobile.becomeFirstResponder()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         scrollView.setContentOffset(CGPoint.init(x: 0, y: 180), animated: true)
    }
    
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    @IBAction func proceedClicked(_ sender: Any) {
        var strMessage = ""
        let strNumber = txtMobile.text!.trimmingCharacters(in: .whitespaces)
        
        if(strNumber.count <= 0){
            strMessage = "Please enter mobile number"
        } else if (strNumber.count < 11) {
            strMessage = "Please enter valid mobile number"
        }
        
        if(strMessage.count > 0){
            Utils.showAlert(withMessage: strMessage)
            return
        }
        loginApicall()
        
    }
    
    func loginApicall ()  {
        let account = Account()
        account.mobileNumber = String(txtMobile.text!).replacingOccurrences(of: " ", with: "")
        self.startAnimating()
        account.loginApicall { (isSuccess, account, errorMessage) -> (Void) in
            self.stopAnimating()
            if(errorMessage.count > 0){
                if(errorMessage.contains("Internet")){
                    self.openNoInternetView()
                } else {
                    Utils.showAlert(withMessage: errorMessage)
                    return
                }
            }
           
            if(account.existing == "true"){
                let vc = VerifyOTPVC.initViewController(account: account)
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = CreateAccountVC.initViewController(account: account)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func openNoInternetView()  {
        let vc = InternetVc.initViewController()
        vc.delegate = self
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    func retryClicked() {
        loginApicall()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
         scrollView.setContentOffset(CGPoint.init(x: 0, y: 180), animated: true)
    }
    
    func textField (_ textField :  UITextField, shouldChangeCharactersIn range:  NSRange, replacementString string:  String  )  ->  Bool {
        if textField ==  self.txtMobile {
            let textString = NSString(format:"%@",textField.text!)
            let newString = textString.replacingCharacters(in: range, with: string) as NSString
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "") as NSString
            let length = components.length
            let hasLeadingOne = length > 0 && components.character(at: 0) == (1 as unichar)
            if length == 0 || (length > 9 && !hasLeadingOne) || length > 10 {
                let newLength = textString.length + (string as NSString).length - range.length as Int
                return (newLength > 8) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 3 {
                let areaCode = components.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@ ", areaCode)
                index += 3
            }
            if length - index > 3 {
                let prefix = components.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@ ", prefix)
                index += 3
            }
//            if (textString.length) == 0 &&  newString != "0" {
//                formattedString.appendFormat("0%@",textString)
//                textField.text = formattedString as String
//            }
            let remainder = components.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        }
        return true
    }
    
}
