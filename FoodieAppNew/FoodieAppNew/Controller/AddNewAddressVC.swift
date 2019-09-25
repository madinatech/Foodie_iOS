
import UIKit

class AddNewAddressVC: UIViewController {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var txtTitle: CommonTextfield!
    @IBOutlet weak var txtLine1: CommonTextfield!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtLine2: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    class func initViewController() -> AddNewAddressVC {
        let vc = AddNewAddressVC.init(nibName: "AddNewAddressVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       
    }

    @IBAction func saveClicked(_ sender: Any) {
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func areaClicked(_ sender: Any) {
    }
    
    @IBAction func cityClicked(_ sender: Any) {
    }
    
}
