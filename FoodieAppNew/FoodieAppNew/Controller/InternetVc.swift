

import UIKit
@objc protocol InternetDelegate {
    func retryClicked()
}
class InternetVc: UIViewController {
    
    @IBOutlet weak var btnRetry: UIButton!
      var delegate :  InternetDelegate? = nil
    class func initViewController() -> InternetVc {
        let vc = InternetVc.init(nibName: "InternetVc", bundle: nil)
      
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRetry.layer.borderColor = appThemeColor.cgColor
        btnRetry.layer.borderWidth = 1
     
    }

    @IBAction func retryClicked(_ sender: Any) {
        if(delegate != nil){
            self.dismiss(animated: false) {
                self.delegate?.retryClicked()
            }
        }
    }
    
}
