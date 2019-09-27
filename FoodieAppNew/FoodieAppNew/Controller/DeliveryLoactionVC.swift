
import UIKit
import ActionSheetPicker_3_0

@objc protocol DeliveryLocationDelegate {
    func selectedArea(area: Area)
}
class DeliveryLoactionVC: UIViewController , UIGestureRecognizerDelegate{
    
    @IBOutlet weak var txtCity: CommonTextfield!
    @IBOutlet weak var txtArea: CommonTextfield!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var innerView: UIView!
    var cityArray = [City]()
    var areaArray = [Area]()
    var selectdCity = City()
    var isCitySelectd = Bool()
    var selectedArea = Area()
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
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if(UserDefaults.standard.object(forKey: Selected_Area) == nil){
          getClientToken()
        } else {
             getCountryApi()
        }
       
    }
    
    func getClientToken ()  {
        let account = Account()
        account.getClientToken { (isSuccess, account, errorMessage) -> (Void) in
            if(errorMessage.count > 0){
                Utils.showAlert(withMessage: errorMessage)
            }
            self.getCountryApi()
        }
    }
    
    func getCountryApi()  {
        Manager.sharedManager().loadCountry { (response, errorMessage) -> (Void) in
            if(errorMessage.count > 0){
                Utils.showAlert(withMessage: errorMessage)
            }
            let country = Country.getCountryByName(name: "Tanzania")
            if(country.country_id != 0){
                self.cityArray = country.cities.allObjects as! [City]
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
        if(isCitySelectd == true){
            var areaNameArray = [String]()
            for area in areaArray{
                areaNameArray.append(area.name ?? "")
            }
            areaNameArray.sort()
            if(areaNameArray.count <= 0){
                return
            }
            ActionSheetStringPicker.show(withTitle: "Select Area", rows: areaNameArray, initialSelection: 0
                , doneBlock: { (picker, index, value) in
                    self.txtArea.text = areaNameArray[index]
                    self.selectedArea = Area.getAreaByName(name: self.txtArea.text ?? "")
            }, cancel: { (picker) in
                
            }, origin: sender)
        } else {
            Utils.showAlert(withMessage: "Please first select city")
        }
    }
    
    
    @IBAction func cityClicked(_ sender: Any) {
        var cityNameArray = [String]()
        for city in cityArray{
            cityNameArray.append(city.city_name ?? "")
        }
        cityNameArray.sort()
        ActionSheetStringPicker.show(withTitle: "Select City", rows: cityNameArray, initialSelection: 0
            , doneBlock: { (picker, index, value) in
                self.isCitySelectd = true
                self.txtCity.text = cityNameArray[index]
                self.selectdCity = City.getCityByName(name: self.txtCity.text ?? "")
                self.areaArray = self.selectdCity.areas.allObjects as! [Area]
        }, cancel: { (picker) in
            
        }, origin: sender)
    }
}
