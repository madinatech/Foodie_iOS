
import UIKit

class BaseViewController: UIViewController {
    
    var isFromPresentVC : Bool = false
    var isBackButtonHidden : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var left_img = UIImage(named: "Left_Arrow")
        left_img = left_img?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        let left_button = UIBarButtonItem(image: left_img, style: .plain, target: self, action: #selector(self.backClicked))
        left_button.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        left_button.tintColor = .clear
        if(isBackButtonHidden == false){
            left_button.tintColor = .white
        }
        navigationItem.leftBarButtonItem = left_button
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = appThemeColor
//        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = appThemeColor
        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
    }
    
    @objc func backClicked() {
        if(isBackButtonHidden == false){
            if isFromPresentVC == true {
                navigationController?.dismiss(animated: true, completion: nil)
            } else{
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
