
import UIKit

class LoginVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
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
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         txtMobile.becomeFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        //        scrollView.scrollsToTop = true
    }
    @objc func keyboardWillShow(notification: NSNotification) {
       
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 120), animated: true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }

    @IBAction func proceedClicked(_ sender: Any) {
        let vc = VerifyOTPVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textField (_ textField :  UITextField, shouldChangeCharactersIn range:  NSRange, replacementString string:  String  )  ->  Bool {
        if textField ==  self.txtMobile {
            let textString = NSString(format:"%@",textField.text!)
            let newString = textString.replacingCharacters(in: range, with: string) as NSString
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "") as NSString
            let length = components.length
            let hasLeadingOne = length > 0 && components.character(at: 0) == (1 as unichar)
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = textString.length + (string as NSString).length - range.length as Int
                return (newLength > 9) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 4 {
                let areaCode = components.substring(with: NSMakeRange(index, 4))
                formattedString.appendFormat("%@ ", areaCode)
                index += 4
            }
            if length - index > 3 {
                let prefix = components.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@ ", prefix)
                index += 3
            }
            if (textString.length) == 0 &&  newString != "0" {
                formattedString.appendFormat("0%@",textString)
                textField.text = formattedString as String
            }
            let remainder = components.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        }
        return true
    }
    
}
