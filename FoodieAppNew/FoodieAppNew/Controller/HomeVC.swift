
import UIKit
import AMShimmer
import MagicalRecord

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RecommendedDelegate , DeliveryAddressDelegate, DeliveryLocationDelegate{
    
    @IBOutlet weak var lblAddressTitle: UILabel!
    @IBOutlet weak var lblHungry: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var isLoaded = Bool()
    var restaurantArray = [Restaurant]()
    var selectedAddress : Address = Address.mr_createEntity()!
    var selectedArea : Area = Area.mr_createEntity()!
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
            lblHungry.text = "Are you hungry \(AccountManager.instance().activeAccount?.user_Name ?? "")?"
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
     
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.restaurantArray = Restaurant.getAll()
        tblView.reloadData()
    }
    
    func getClientToken ()  {
        let account = Account()
        account.getClientToken { (isSuccess, account, errorMessage) -> (Void) in
            if(errorMessage.count > 0){
                Utils.showAlert(withMessage: errorMessage)
            }
            self.getRestaurantListapi()
        }
    }
    
    func getRestaurantListapi () {
        self.restaurantArray = Restaurant.getAll()
        if(restaurantArray.count > 0){
            self.isLoaded = true
        }
        self.tblView.reloadData()
        var areaId = Int()
        if(selectedArea.entity_id != 0){
            areaId = Int(selectedArea.entity_id)
        } else {
            areaId = Int(Utils.fetchString(forKey: SelectedArea_id))!
        }
        Manager.sharedManager().loadRestaurentList(area: areaId) { (response, errorMessage) -> (Void) in
            if(errorMessage.count > 0){
                Utils.showAlert(withMessage: errorMessage)
            }
            self.isLoaded = true
            self.restaurantArray = Restaurant.getAll()
            self.tblView.reloadData()
        }
    }
    
    @IBAction func deliveryAddressClicked(_ sender: Any) {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        return restaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.white
//        let lblTitle = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: tblView.frame.width - 10, height: 50))
//        lblTitle.font = UIFont.init(name: "Calibri-Bold", size: 20)
        let btnFiler = UIButton.init(frame: CGRect.init(x: tblView.frame.width - 40, y: 15, width: 20, height: 20))
        btnFiler.setImage(UIImage.init(named: "settings"), for: .normal)
        btnFiler.setTitleColor(.black, for: .normal)
        btnFiler.titleLabel?.font = UIFont.init(name: "Calibri", size: 16)
        if(section == 0){
//            lblTitle.text = ""//"Delivers in under 30 minutes"
            btnFiler.isHidden = true
        } else {
//            lblTitle.text = ""//"All Restaurants"
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
//        headerView.addSubview(lblTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 170
        } else {
            return 110//UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        }
        return 50
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
            AMShimmer.stop(for: cell!.contentView)
            return cell!
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as? RestaurantCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("RestaurantCell", owner: self, options: nil)
            cell = nib?[0] as? RestaurantCell
        }
        cell?.selectionStyle = .none
        let restaurant : Restaurant = restaurantArray[indexPath.row]
        if isLoaded == true{
            cell?.hideLoader()
        } else {
            cell?.showLoader()
        }
        
        cell?.showData(restaurant: restaurant)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        let restaurant : Restaurant = restaurantArray[indexPath.row]
        let vc = RestaurantDetailVC.initViewController(restaurant: restaurant)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filterClicked(_ sender: UIButton) {
        let vc = FilterVC.initViewController()
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    //    RecommendedDelegate
    func navigatetoDetail() {
        //        let vc = RestaurantDetailVC.initViewController()
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //DeliveryAddressDelegate
    func selectedAddress(address: Address) {
        selectedAddress = address
        lblAddressTitle.text = selectedAddress.address_type
        clearRestaurantData()
        getRestaurantListapi()
        //        getRestaurantListapi()
    }
    
    //    DeliveryLocationDelegate
    func selectedArea(area: Area) {
        selectedArea = area
        lblAddressTitle.text = area.name
        clearRestaurantData()
        getRestaurantListapi()
        //        getRestaurantListapi()
    }
    
    func clearRestaurantData()  {
        MagicalRecord.save(blockAndWait: { (localContext:NSManagedObjectContext) in
            Restaurant.mr_truncateAll(in: localContext)
        })
    }
}
