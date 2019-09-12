
import UIKit
import GoogleMaps
import GooglePlaces

class DeliveryLoactionVC: BaseViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    class func initViewController() -> DeliveryLoactionVC {
        let vc = DeliveryLoactionVC.init(nibName: "DeliveryLoactionVC", bundle: nil)
        vc.title = "Delivery Location"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.isBackButtonHidden = true
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        placesClient = GMSPlacesClient.shared()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
    }

    @IBAction func currentLocationClicked(_ sender: Any) {
       
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        print("LAt: \(location?.coordinate.latitude ?? 0.0)")
        print("Long: \(location?.coordinate.longitude ?? 0.0)")
        self.locationManager.stopUpdatingLocation()
        getAddressFromLatLon(pdblLatitude: location?.coordinate.latitude ?? 0.0, withLongitude: location?.coordinate.longitude ?? 0.0 )
//        placesClient.currentPlace { (place, error) in
//            if let error = error {
//                // TODO: Handle the error.
//                print("Current Place error: \(error.localizedDescription)")
//                return
//            }
//            if let likelihoodList = place {
//                for likelihood in likelihoodList.likelihoods {
//                    let plac = likelihood.place
//                    print(plac)
//                }
//            }
//        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = pdblLatitude
        //21.228124
        let lon: Double = pdblLongitude
    
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    return
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country ?? "")
                    print(pm.locality ?? "")
                    print(pm.subLocality ?? "")
                    print(pm.thoroughfare ?? "")
                    print(pm.postalCode ?? "")
                    print(pm.subThoroughfare ?? "")
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    print(addressString)
                }
        })
        
    }
    
    @IBAction func areaClicked(_ sender: Any) {
        let vc = AreaVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func seeAllVendors(_ sender: Any) {
        appDelegateShared?.showTabbar()
//        let vc = RestaurantsVC.initViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func cityClicked(_ sender: Any) {
        let vc = CityVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
