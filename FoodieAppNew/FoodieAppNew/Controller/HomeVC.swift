
import UIKit
import AMShimmer
import MagicalRecord

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RecommendedDelegate , DeliveryAddressDelegate, DeliveryLocationDelegate, filterDelegate{
    
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var imgInternet: UIImageView!
    @IBOutlet weak var internetView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnEditLocation: UIButton!
    @IBOutlet weak var btnRetry: UIButton!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblAddressTitle: UILabel!
    @IBOutlet weak var lblHungry: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var isLoaded = Bool()
    var restaurantArray = [Restaurant]()
    var selectedAddress : Address = Address.mr_createEntity()!
    var areaId = Int()
    var selectedCusines = [String]()
    var selectdTopIndexes = NSMutableArray()
    var offerIndex : Int = -1
    
    class func initViewController() -> HomeVC {
        let vc = HomeVC.init(nibName: "HomeVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.tableFooterView = UIView()
        tblView.rowHeight = 110
        tblView.estimatedRowHeight = UITableView.automaticDimension
        isLoaded = false
        if(AccountManager.instance().activeAccount != nil){
            let name : String = AccountManager.instance().activeAccount?.user_Name ?? ""
            let nameArray = name.split(separator: " ")
            lblHungry.text = "Are you hungry \(nameArray[0])?"
        } else {
            lblHungry.text = "Are you hungry?"
            lblAddressTitle.text = Utils.fetchString(forKey: Selected_Area)
        }
        selectedAddress = Address.getSelectedAddress()
        if(selectedAddress.entity_id != 0){
            lblAddressTitle.text = selectedAddress.address_type
        } else {
            selectedAddress = Address.getUserDefaultAddress(userID: Int(AccountManager.instance().activeAccount?.user_id ?? "") ?? 0)
            if(selectedAddress.entity_id != 0){
                lblAddressTitle.text = selectedAddress.address_type
            } else {
                lblAddressTitle.text = Utils.fetchString(forKey: Selected_Area)
            }
        }
        getClientToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.deliveryView.isHidden = true
        self.internetView.isHidden = true
        btnEditLocation.layer.borderColor = appThemeColor.cgColor
        btnEditLocation.layer.borderWidth = 1
        btnRetry.layer.borderColor = appThemeColor.cgColor
        btnRetry.layer.borderWidth = 1
        let noDelivery = UIImage.gifImageWithName("nodelivery_1-2")
        imgView.image = noDelivery
        if(self.restaurantArray.count <= 0){
            self.tblViewHeight.constant = 170
            self.deliveryView.isHidden = false
            self.internetView.isHidden = true
        } else {
            self.tblViewHeight.constant = self.view.frame.height - 120
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if(selectedCusines.count <= 0){
            restaurantArray = Restaurant.getAll()
        } else {
            restaurantArray = Restaurant.getAllByCusines(cusinesName: selectedCusines)
        }
        tblView.reloadData()
    }
    
    func getClientToken ()  {
        isLoaded = false
        let account = Account()
        account.getClientToken { (isSuccess, account, errorMessage) -> (Void) in
            if(errorMessage.count > 0){
                if(errorMessage.contains("Internet")){
                    self.tblViewHeight.constant = 170
                    self.deliveryView.isHidden = true
                    self.internetView.isHidden = false
                } else {
                    Utils.showAlert(withMessage: errorMessage)
                }
            } else {
                self.getRestaurantListapi()
            }
        }
    }
    
    func getRestaurantListapi () {
        isLoaded = false
//        self.restaurantArray = Restaurant.getAllRestaurant()
//        if(restaurantArray.count > 0){
//            self.isLoaded = true
//        }
        self.tblView.reloadData()
        self.tblViewHeight.constant = self.view.frame.height - 120
        self.view.layoutIfNeeded()
        if(areaId == 0){
            areaId = Int(Utils.fetchString(forKey: SelectedArea_id))!
        }
        
        Manager.sharedManager().loadRestaurentList(area: areaId) { (response, errorMessage) -> (Void) in
            if(errorMessage.count > 0){
                //                Utils.showAlert(withMessage: errorMessage)
                if(errorMessage.contains("Internet")){
                    self.tblViewHeight.constant = 170
                    self.deliveryView.isHidden = true
                    self.internetView.isHidden = false
                }
                
            } else{
                self.isLoaded = true
                self.restaurantArray = Restaurant.getAllRestaurant()
                
                self.tblView.reloadData()
                if(self.restaurantArray.count <= 0){
                    self.tblViewHeight.constant = 170
                    self.deliveryView.isHidden = false
                    self.internetView.isHidden = true
                } else {
                    self.tblViewHeight.constant = self.view.frame.height - 120
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func chooseAddress ()  {
        if(AccountManager.instance().activeAccount != nil){
            let vc = DeliveryAddressVC.initViewController(selectedAddress: selectedAddress)
            vc.delegate = self
            let nav = UINavigationController.init(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        } else {
            let vc = DeliveryLoactionVC.initViewController()
            vc.delegate = self
            let nav = UINavigationController.init(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    @IBAction func retryClicked(_ sender: Any) {
        getClientToken()
    }
    @IBAction func editLocationClicked(_ sender: Any) {
        chooseAddress()
    }
    
    @IBAction func deliveryAddressClicked(_ sender: Any) {
        chooseAddress()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        if(restaurantArray.count > 0){
            return restaurantArray.count
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.white
        let btnFiler = UIButton.init(frame: CGRect.init(x: tblView.frame.width - 40, y: 15, width: 20, height: 20))
        btnFiler.setImage(UIImage.init(named: "settings"), for: .normal)
        btnFiler.setTitleColor(.black, for: .normal)
        btnFiler.titleLabel?.font = UIFont.init(name: "Calibri", size: 16)
        if(section == 0){
            btnFiler.isHidden = true
        } else {
            btnFiler.isHidden = false
        }
        if(section == 1){
            headerView.backgroundColor = appLigtGrayColor
            headerView.layer.cornerRadius = 20
            headerView.clipsToBounds = true
            headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        btnFiler.addTarget(self, action: #selector(filterClicked(_:)), for: .touchUpInside)
        headerView.addSubview(btnFiler)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 170
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        }
        if(restaurantArray.count > 0){
            return 50
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedRestaurantCell") as? RecommendedRestaurantCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("RecommendedRestaurantCell", owner: self, options: nil)
                cell = nib?[0] as? RecommendedRestaurantCell
            }
            cell?.selectionStyle = .none
            cell?.delegate = self
            //            cell?.setdata(isOfferData: isOfferData)
            AMShimmer.stop(for: cell!.contentView)
            return cell!
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as? RestaurantCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("RestaurantCell", owner: self, options: nil)
            cell = nib?[0] as? RestaurantCell
        }
        cell?.selectionStyle = .none
        if(restaurantArray.count > 0){
            let restaurant : Restaurant = restaurantArray[indexPath.row]
            if isLoaded == true{
                cell?.hideLoader()
            } else {
                cell?.showLoader()
            }
            
            cell?.showData(restaurant: restaurant, offerIndex: offerIndex)
        } else{
            cell?.showLoader()
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        let restaurant : Restaurant = restaurantArray[indexPath.row]
        if(restaurant.is_closed == false){
            let vc = RestaurantDetailVC.initViewController(restaurant: restaurant)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func filterClicked(_ sender: UIButton) {
        let vc = FilterVC.initViewController(selectdCusines: selectedCusines)
        vc.delegate = self
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    //    filterDelegate
    
    func applyFilter(cusinesName: [String]) {
        selectedCusines = cusinesName
        if(cusinesName.count <= 0){
            restaurantArray = Restaurant.getAll()
        } else {
            restaurantArray = Restaurant.getAllByCusines(cusinesName: cusinesName)
        }
        tblView.reloadData()
    }
    func resetFilter(cusinesName: [String]) {
        selectedCusines = cusinesName
        restaurantArray = Restaurant.getAll()
        tblView.reloadData()
    }
    
    //    RecommendedDelegate
    func showOfferingData(index: Int) {
        if(selectdTopIndexes.contains(index)){
            selectdTopIndexes.remove(index)
        } else {
            selectdTopIndexes.add(index)
        }
        if(index == 0){
            offerIndex = index
            restaurantArray = Restaurant.getDeliveryUnder()
        } else if(index == 1){
            offerIndex = index
            restaurantArray = Restaurant.getPickupRestaurants()
        } else {
            offerIndex = index
            restaurantArray = Restaurant.getDineInRestaurants()
        }
        
        if(!selectdTopIndexes.contains(index)){
            offerIndex = -1
            restaurantArray = Restaurant.getAll()
        }
        
        tblView.reloadSections(IndexSet(integersIn: 1...1), with: UITableView.RowAnimation.automatic)
    }
    
    //DeliveryAddressDelegate
    func selectedAddress(address: Address) {
        selectedAddress = address
        areaId = Int(selectedAddress.area_id)
        lblAddressTitle.text = selectedAddress.address_type
        clearRestaurantData()
        isLoaded = false
        getRestaurantListapi()
    }
    
    //    DeliveryLocationDelegate
    func selectedArea(area: Area) {
        lblAddressTitle.text = area.name
        areaId = Int(area.entity_id)
        clearRestaurantData()
        isLoaded = false
        getRestaurantListapi()
    }
    
    func clearRestaurantData()  {
        MagicalRecord.save(blockAndWait: { (localContext:NSManagedObjectContext) in
            Restaurant.mr_truncateAll(in: localContext)
            Cusines.mr_truncateAll(in: localContext)
            Images.mr_truncateAll(in: localContext)
            Location.mr_truncateAll(in: localContext)
            Menu.mr_truncateAll(in: localContext)
            OpeningTimes.mr_truncateAll(in: localContext)
            Items.mr_truncateAll(in: localContext)
            CustomizationGroup.mr_truncateAll(in: localContext)
            Price.mr_truncateAll(in: localContext)
            GroupValues.mr_truncateAll(in: localContext)
        })
    }
    
    
    
    
}
