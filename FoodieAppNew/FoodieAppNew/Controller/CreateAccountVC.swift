
import UIKit

class CreateAccountVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var txt1: CommonTextfield!
    @IBOutlet weak var txt2: CommonTextfield!
    @IBOutlet weak var txt3: CommonTextfield!
    @IBOutlet weak var txt4: CommonTextfield!
      @IBOutlet weak var scrollView: UIScrollView!
    class func initViewController() -> CreateAccountVC {
        let vc = CreateAccountVC.init(nibName: "CreateAccountVC", bundle: nil)
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
        super.viewWillAppear(animated)
         txt1.becomeFirstResponder()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        //        scrollView.scrollsToTop = true
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 110), animated: true)
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
                txt4.becomeFirstResponder()
            default:
                break
            }
        }
    }
  

}
