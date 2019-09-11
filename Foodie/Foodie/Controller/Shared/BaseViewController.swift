
import UIKit

class BaseViewController: UIViewController {
    
    var isFromPresentVC : Bool = false
    var isBackButtonHidden : Bool = false
    var isHome : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(isHome == true){
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 40))
            let label = UILabel()
            label.text = "Location"
            label.font = UIFont.init(name: "Helvetica Bold", size: 18)
            label.textColor = .white
            label.sizeToFit()
//            label.center = view.center
            label.frame.origin.y = view.center.y - 10
            label.textAlignment = NSTextAlignment.center
            view.addSubview(label)
            let image = UIImageView()
            image.image = UIImage(named: "downArrow_white")
            image.contentMode = UIView.ContentMode.scaleAspectFit
            image.frame = CGRect.init(x: label.frame.width + label.frame.origin.x + 5, y: label.frame.origin.y + 6 , width: 10, height: 10 )
            view.addSubview(image)
            let button =  UIButton(type: .custom)
            button.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width + image.frame.width + 20, height: label.frame.height)
            button.addTarget(self, action: #selector(clickOnButton(_:)), for: .touchUpInside)
            view.addSubview(button)
            let barbutton = UIBarButtonItem.init(customView: view)
            navigationItem.leftBarButtonItem = barbutton
        } else {
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
    }
    
    @IBAction func clickOnButton(_ sender: Any) {
        let vc = ManageAddressVC.initViewController()
        self.navigationController?.present(vc, animated: true, completion: nil)
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
//        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
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
