
import UIKit
import ActionSheetPicker_3_0


@objc protocol DeliveryLocationDelegate {
    func selectedArea(area: Area)
}
class DeliveryLoactionVC: UIViewController , UIGestureRecognizerDelegate{
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgLocation: UIImageView!
    @IBOutlet weak var txtCity: CommonTextfield!
    @IBOutlet weak var txtArea: CommonTextfield!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var innerView: UIView!
    var cityArray = [City]()
    var areaArray = [Area]()
    var selectdCity : City = City.mr_createEntity()!
    var selectedArea = Area.mr_createEntity()!
    var delegate :  DeliveryLocationDelegate? = nil
    
    class func initViewController() -> DeliveryLoactionVC {
        let vc = DeliveryLoactionVC.init(nibName: "DeliveryLoactionVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        topView.addGestureRecognizer(tap)
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        if(UserDefaults.standard.object(forKey: Selected_Area) == nil){
            imgLocation.isHidden = false
            lblTitle.isHidden = false
            lblDesc.isHidden = false
//            getClientToken()
        } else {
            imgLocation.isHidden = true
            lblTitle.isHidden = true
            lblDesc.isHidden = true
//            getCountryApi()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        selectdCity = City.getSelectedCity()
        if(selectdCity.city_name != nil){
            txtCity.text = selectdCity.city_name
            areaArray = selectdCity.areas.allObjects as! [Area]
            for area in areaArray{
                if(area.is_selected == true){
                    selectedArea = area
                    txtArea.text = selectedArea.name
                }
            }
        }
    }
    
    @IBAction func confirmClicked(_ sender: Any) {
        var strMessage = String()
        let strCity = txtCity.text!.trimmingCharacters(in: .whitespaces)
        let strArea = txtArea.text!.trimmingCharacters(in: .whitespaces)
        if(strCity.count <= 0){
            strMessage = "Please select city"
        } else if(strArea.count <= 0){
            strMessage = "Please select area"
        }
        
        if(strMessage.count > 0){
            Utils.showAlert(withMessage: strMessage)
            return
        }
        
        Utils.setStringForKey(selectedArea.name ?? "", key: Selected_Area)
        Utils.setStringForKey("\(selectedArea.entity_id)", key: SelectedArea_id)
        
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.selectedArea(area: self.selectedArea)
            }
        } else{
            appDelegateShared?.showTabbar()
        }
    }
    
    
    @IBAction func areaClicked(_ sender: Any) {
        var strMessage = String()
        let strCity = txtCity.text!.trimmingCharacters(in: .whitespaces)
        
        if(strCity.count <= 0){
            strMessage = "Please select city"
        }
        
        if(strMessage.count > 0){
            Utils.showAlert(withMessage: strMessage)
            return
        }
        
        let vc = AreaVC.initViewController(city: selectdCity)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func cityClicked(_ sender: Any) {
        let vc = CityVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
