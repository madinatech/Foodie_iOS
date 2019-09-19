
import UIKit
import AMShimmer

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RecommendedDelegate {
    
    @IBOutlet weak var tblView: UITableView!
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


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        tblView.reloadData()
        AMShimmer.start(for: tblView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            AMShimmer.stop(for: self.tblView)
        }
    }
    @IBAction func deliveryAddressClicked(_ sender: Any) {
        let vc = DeliveryAddressVC.initViewController()
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
            lblTitle.text = "All Restaurants"
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
        let vc = FilterVC.initViewController()
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    //    RecommendedDelegate
    func navigatetoDetail() {
//        let vc = RestaurantDetailVC.initViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }

}