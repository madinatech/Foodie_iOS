

import UIKit

class CityVC: UIViewController, UITableViewDelegate, UITableViewDataSource, InternetDelegate {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tblView: UITableView!
    var cityArray = [City]()
    let loaderView = LoaderView.instanceFromNib()
    
    class func initViewController() -> CityVC {
        let vc = CityVC.init(nibName: "CityVC", bundle: nil)
        vc.title = "City"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        loaderView.frame = self.view.bounds
        self.view.addSubview(loaderView)
        if(UserDefaults.standard.object(forKey: Selected_Area) == nil){
            getClientToken()
        } else {
            getCountryApi()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         loaderView.frame = self.view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         loaderView.frame = self.view.bounds
    }
    
    func getClientToken ()  {
        let account = Account()
        account.getClientToken { (isSuccess, account, errorMessage) -> (Void) in
            if(errorMessage.count > 0){
                self.loaderView.removeFromSuperview()
                if(errorMessage.contains("Internet")){
                    self.openNoInternetView()
                } else {
                    Utils.showAlert(withMessage: errorMessage)
                    return
                }
            }
            self.getCountryApi()
        }
    }
    
    func getCountryApi()  {
        Manager.sharedManager().loadCountry { (response, errorMessage) -> (Void) in
            self.loaderView.removeFromSuperview()
            if(errorMessage.count > 0){
                if(errorMessage.contains("Internet")){
                    self.openNoInternetView()
                } else {
                    Utils.showAlert(withMessage: errorMessage)
                    return
                }
            }
            let country = Country.getCountryByName(name: "Tanzania")
            if(country.country_id != 0){
                self.cityArray = country.cities.allObjects as! [City]
                self.cityArray = self.cityArray.sorted(by: {
                    ($0.city_name!.localizedLowercase) <
                        ($1.city_name!.localizedLowercase)
                } )
            }
            self.tblView.reloadData()
        }
    }
    
    func openNoInternetView()  {
        let vc = InternetVc.initViewController()
        vc.delegate = self
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    func retryClicked() {
        getClientToken()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as? CityCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("CityCell", owner: self, options: nil)
            cell = nib?[0] as? CityCell
        }
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        let city = cityArray[indexPath.row]
        cell?.lblName.text = city.city_name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        for c in cityArray{
            c.is_selected = false
        }
        let city = cityArray[indexPath.row]
        city.is_selected = true
        let vc = AreaVC.initViewController(city: city)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}




