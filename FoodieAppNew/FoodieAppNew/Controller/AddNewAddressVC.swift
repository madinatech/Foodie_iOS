
import UIKit
import ActionSheetPicker_3_0
import NVActivityIndicatorView

class AddNewAddressVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var txtTitle: CommonTextfield!
    @IBOutlet weak var txtLine1: CommonTextfield!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtLine2: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    var cityArray = [City]()
    var areaArray = [Area]()
    var selectdCity = City()
    var isCitySelectd = Bool()
    var isDefault = Int()
    
    class func initViewController() -> AddNewAddressVC {
        let vc = AddNewAddressVC.init(nibName: "AddNewAddressVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       getCountryApi()
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
    
    

    @IBAction func saveClicked(_ sender: Any) {
        var strMessage = String()
        let strTitle = txtTitle.text!.trimmingCharacters(in: .whitespaces)
        let strLine1 = txtLine1.text!.trimmingCharacters(in: .whitespaces)
        let strLine2 = txtLine2.text!.trimmingCharacters(in: .whitespaces)
        let strCity = txtCity.text!.trimmingCharacters(in: .whitespaces)
         let strArea = txtArea.text!.trimmingCharacters(in: .whitespaces)
        if(strTitle.count <= 0){
            strMessage = "Please enter Title"
        } else if(strLine1.count <= 0){
            strMessage = "Please enter Line1"
        } else if(strLine2.count <= 0){
            strMessage = "Please enter Line2"
        } else if(strCity.count <= 0){
            strMessage = "Please select city"
        } else if(strArea.count <= 0){
            strMessage = "Please select area"
        }
        
        if(strMessage.count > 0){
            Utils.showAlert(withMessage: strMessage)
            return
        }
        addNewAddressApi()
    }
    
    func addNewAddressApi() {
        let strLine1 = txtLine1.text!.trimmingCharacters(in: .whitespaces)
        let strLine2 = txtLine2.text!.trimmingCharacters(in: .whitespaces)
         let strArea = txtArea.text!.trimmingCharacters(in: .whitespaces)
        let address : String = strLine1 + strLine2
        self.startAnimating()
        Manager.sharedManager().addNewAddress(address: address + strArea, addressType:txtTitle.text ?? "", city: txtCity.text ?? "", town: txtArea.text ?? "", street: txtLine1.text ?? "", landmark: txtLine2.text ?? "", isDefault: isDefault) { (response, errorMessage) -> (Void) in
            self.stopAnimating()
            if(errorMessage.count > 0){
                Utils.showAlert(withMessage: errorMessage)
            }
             self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func defaultClicked(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
            isDefault = 0
        } else {
            sender.isSelected = true
            isDefault = 1
        }
    }
}