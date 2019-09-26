
import UIKit
import AMShimmer

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RecommendedDelegate {
    
    @IBOutlet weak var lblHungry: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var isLoaded = Bool()
    var restaurantArray = [Restaurant]()
    class func initViewController() -> HomeVC {
        let vc = HomeVC.init(nibName: "HomeVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.tableFooterView = UIView()
        tblView.rowHeight = 110
        tblView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isLoaded = false
        if(AccountManager.instance().activeAccount != nil){
            lblHungry.text = "Are you hungry \(AccountManager.instance().activeAccount?.user_Name ?? "")?"
        } else {
              lblHungry.text = "Are you hungry?"
        }
        getClientToken()
//        getRestaurantListapi()
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
        Manager.sharedManager().loadRestaurentList(area: "kisutu") { (response, errorMessage) -> (Void) in
            if(errorMessage.count > 0){
                Utils.showAlert(withMessage: errorMessage)
            }
            self.isLoaded = true
            self.restaurantArray = Restaurant.getAll()
            self.tblView.reloadData()
        }
    }
    
    @IBAction func deliveryAddressClicked(_ sender: Any) {
        let vc = DeliveryAddressVC.initViewController()
        let nav = UINavigationController.init(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
//        self.navigationController?.present(vc, animated: true, completion: nil)
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
        let lblTitle = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: tblView.frame.width - 10, height: 50))
        lblTitle.font = UIFont.init(name: "Calibri-Bold", size: 20)
        
        let btnFiler = UIButton.init(frame: CGRect.init(x: tblView.frame.width - 40, y: 15, width: 20, height: 20))
//        btnFiler.setTitle("Sort / Filter", for: .normal)
        btnFiler.setImage(UIImage.init(named: "settings"), for: .normal)
        btnFiler.setTitleColor(.black, for: .normal)
        btnFiler.titleLabel?.font = UIFont.init(name: "Calibri", size: 16)
        if(section == 0){
            lblTitle.text = ""//"Delivers in under 30 minutes"
            btnFiler.isHidden = true
        } else {
            lblTitle.text = ""//"All Restaurants"
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
        headerView.addSubview(lblTitle)
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

}
