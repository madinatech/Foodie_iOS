

import UIKit
import AMShimmer

class RestaurantDetailVC: UIViewController,UITableViewDelegate, UITableViewDataSource, ResDetailTabSectionDelegate , ResDetailHeaderDelegate {
    
    @IBOutlet weak var tblViewTop: NSLayoutConstraint!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var tblView: UITableView!
    var categoryArray = [String]()
    var categoryCount = Int()
    var restaurant = Restaurant()
    var selectedTab = Int()
    var menuArray = [Menu]()
    var itemsArray = [Items]()
    var selectedMenu = Menu()
    
    class func initViewController(restaurant: Restaurant) -> RestaurantDetailVC {
        let vc = RestaurantDetailVC.init(nibName: "RestaurantDetailVC", bundle: nil)
        vc.restaurant = restaurant
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.layer.cornerRadius = 20
        cartView.clipsToBounds = true
        cartView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tblView.tableFooterView = UIView()
         categoryArray = ["Promo","Burgers", "Meals","Pizza"]
        categoryCount = 0
        menuArray = restaurant.menus.allObjects as! [Menu]
        menuArray = menuArray.sorted(by: {
            ($0.name!.localizedLowercase) <
                ($1.name!.localizedLowercase)
        } )
        selectedMenu = menuArray[0]
        itemsArray = selectedMenu.items.allObjects as! [Items]
        tblView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedTab = 0
        tblView.reloadData()
        AMShimmer.start(for: tblView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            AMShimmer.stop(for: self.tblView)
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(tblView.contentOffset.y)
        var offset = scrollView.contentOffset.y / 150
        if(offset > 1){
            offset = 1
            self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 205.0/255.0, blue: 92.0/255.0, alpha: offset)
            UIApplication.shared.statusbarView?.backgroundColor = UIColor.init(red: 250.0/255.0, green: 205.0/255.0, blue: 92.0/255.0, alpha: offset)
        } else {
            self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 205.0/255.0, blue: 92.0/255.0, alpha: offset)
            UIApplication.shared.statusbarView?.backgroundColor = UIColor.init(red: 250.0/255.0, green: 205.0/255.0, blue: 92.0/255.0, alpha: offset)
        }
        
        if(tblView.contentOffset.y < 0){
            tblView.reloadData()
        }
        
        if(tblView.contentOffset.y > 390){
            tblViewTop.constant = 0
        } else {
            tblViewTop.constant = 25
        }
        self.view.layoutIfNeeded()
    }
    @IBAction func viewOrderClicked(_ sender: Any) {
        let vc = ViewOrderVC.initViewController()
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0){
            let view : RestaurantDetailHeader = RestaurantDetailHeader.instanceFromNib() as! RestaurantDetailHeader
            view.delegate = self
            view.setData(restaurat: restaurant)
            return view
        } else {
            let view : ResDetailTabSection = ResDetailTabSection.instanceFromNib() as! ResDetailTabSection
            view.delegate = self
            view.setData(sTab: selectedTab, swipeType: "Left", restaurant: restaurant)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 0
        }
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 440
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 5){
            var cell = tableView.dequeueReusableCell(withIdentifier: "RestDetailHeaderCell") as? RestDetailHeaderCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("RestDetailHeaderCell", owner: self, options: nil)
                cell = nib?[0] as? RestDetailHeaderCell
            }
            cell?.selectionStyle = .none
           
            if(categoryCount >= categoryArray.count - 1){
                categoryCount = 0
            } else{
              categoryCount = categoryCount + 1
            }
             cell?.lblHeader.text = categoryArray[categoryCount]
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantDetailCell") as? RestaurantDetailCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("RestaurantDetailCell", owner: self, options: nil)
                cell = nib?[0] as? RestaurantDetailCell
            }
            cell?.selectionStyle = .none
            let item = itemsArray [indexPath.row]
            cell?.showData(item: item)
            return cell!
        }
        
    }

  
    //    ResDetailTabSectionDelegate
    func tabClicked(selectedTab: Int) {
                self.selectedTab = selectedTab
        selectedMenu = menuArray[selectedTab]
        itemsArray = selectedMenu.items.allObjects as! [Items]
        tblView.reloadData()
        AMShimmer.start(for: tblView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            AMShimmer.stop(for: self.tblView)
        }
    }
    //    ResDetailHeaderDelegate
    func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    func infoClicked() {
        let vc = InfoVC.initViewController(restaurant: restaurant)
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
