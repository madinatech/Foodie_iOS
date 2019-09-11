
import UIKit


class TermsVC: BaseViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    class func initViewController() -> TermsVC {
        let vc = TermsVC.init(nibName: "TermsVC", bundle: nil)
        vc.title = "Terms and Conditions"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest.init(url: URL.init(string: "https://www.google.com")!))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
    }

}
