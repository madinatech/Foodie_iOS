
import UIKit
import AMShimmer

class RestaurantsVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, FilterDelegate, RecommendedDelegate {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var filterView: UIView!
    
    class func initViewController() -> RestaurantsVC {
        let vc = RestaurantsVC.init(nibName: "RestaurantsVC", bundle: nil)
        vc.title = "Restaurants"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackButtonHidden = true
        searchView.dropShadow()
        tblView.tableFooterView = UIView()
        tblView.rowHeight = 110
        tblView.estimatedRowHeight = UITableView.automaticDimension
        navigationSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.items?[0].title = "Restaurants"
        self.tabBarController?.tabBar.items?[1].title = "Search"
        self.tabBarController?.tabBar.items?[2].title = "Cart"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        filterView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterView.isHidden = true
        tblView.reloadData()
        AMShimmer.start(for: tblView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            AMShimmer.stop(for: self.tblView)
        }
    }
    
    func navigationSetup (){
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 40))
        let label = UILabel()
        label.text = "Location"
        label.font = UIFont.init(name: "Helvetica Bold", size: 18)
        label.textColor = .white
        label.sizeToFit()
        label.center = view.center
        label.textAlignment = NSTextAlignment.center
        view.addSubview(label)
        let image = UIImageView()
        image.image = UIImage(named: "downArrow")
        image.contentMode = UIView.ContentMode.scaleAspectFit
        image.frame = CGRect.init(x: label.frame.width + label.frame.origin.x + 5, y: label.frame.origin.y + 7 , width: 10, height: 10 )
        view.addSubview(image)
        let button =  UIButton(type: .custom)
        button.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width + image.frame.width + 20, height: label.frame.height)
        button.addTarget(self, action: #selector(clickOnButton(_:)), for: .touchUpInside)
        view.addSubview(button)
        navigationItem.titleView = view
    }
    
    @IBAction func clickOnButton(_ sender: Any) {
        let vc = ManageAddressVC.initViewController()
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.lightGray
        let lblTitle = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: tblView.frame.width - 10, height: 50))
        lblTitle.font = UIFont.init(name: "Helvetica Bold", size: 15)
        
        let btnFiler = UIButton.init(frame: CGRect.init(x: tblView.frame.width - 100, y: 0, width: 100, height: 50))
        btnFiler.setTitle("Sort / Filter", for: .normal)
        btnFiler.titleLabel?.font = UIFont.init(name: "Helvetica", size: 15)
        if(section == 0){
            lblTitle.text = "Delivers in under 40 minutes"
            btnFiler.isHidden = true
        } else {
            lblTitle.text = "All Vendors"
            btnFiler.isHidden = false
        }
        btnFiler.addTarget(self, action: #selector(filterClicked(_:)), for: .touchUpInside)
        headerView.addSubview(btnFiler)
        headerView.addSubview(lblTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 250
        } else {
            return 110//UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
            return cell!
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as? RestaurantCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("RestaurantCell", owner: self, options: nil)
            cell = nib?[0] as? RestaurantCell
        }
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        let vc = RestaurantDetailVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filterClicked(_ sender: UIButton) {
        filterView.isHidden = false
        filterView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let vc = FilterVC.initViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    //    FilterDelegate
    func closeFilter() {
        filterView.isHidden = true
    }
    func applyFilter() {
        filterView.isHidden = true
    }
    
    //    RecommendedDelegate
    func navigatetoDetail() {
        let vc = RestaurantDetailVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
