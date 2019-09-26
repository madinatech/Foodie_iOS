

import UIKit
import AMShimmer

class RestaurantDetailVC: UIViewController,UITableViewDelegate, UITableViewDataSource, ResDetailTabSectionDelegate , ResDetailHeaderDelegate, CustomizeDelegate {
    
    @IBOutlet weak var cartHeight: NSLayoutConstraint!
    @IBOutlet weak var tblViewTop: NSLayoutConstraint!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var tblView: UITableView!
     @IBOutlet weak var blurView: UIView!
    var categoryArray = [String]()
    var categoryCount = Int()
    var restaurant = Restaurant()
    var selectedTab = Int()
    var menuArray = [Menu]()
    var itemsArray = [Items]()
    var selectedMenu = Menu()
    var addItemssArray = NSMutableArray()
    var plusItemssArray = NSMutableArray()
    var minusItemssArray = NSMutableArray()
    
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
        if(menuArray.count > 0){
            selectedMenu = menuArray[0]
            itemsArray = selectedMenu.items.allObjects as! [Items]
            tblView.reloadData()
        }
       
        showCartView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         blurView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedTab = 0
        tblView.reloadData()
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
            cell?.btnAdd.tag = indexPath.row
            cell?.btnPlus.tag = indexPath.row
            cell?.btnDelete.tag = indexPath.row
            cell?.btnAdd.addTarget(self, action: #selector(addClicked(_:)), for: .touchUpInside)
            cell?.btnPlus.addTarget(self, action: #selector(plusClicked(_:)), for: .touchUpInside)
            cell?.btnDelete.addTarget(self, action: #selector(deleteClicked(_:)), for: .touchUpInside)
            
            if(addItemssArray.contains(indexPath.row)){
                cell?.btnAdd.isHidden = true
                cell?.addView.isHidden = false
                cell?.lblQuantity.text = "0"
                
            }
            
            for index in plusItemssArray{
                let i : Int = index as! Int
                if(indexPath.row == i){
                    var a : Int = Int((cell?.lblQuantity.text)!)!
                    a = a + 1
                    cell?.lblQuantity.text = "\(a)"
                    if(a > 1){
                        cell?.btnDelete.setTitle("-", for: .normal)
                         cell?.btnDelete.setImage(nil, for: .normal)
                    } else {
                        cell?.btnDelete.setTitle("", for: .normal)
                        cell?.btnDelete.setImage(UIImage.init(named: "delete"), for: .normal)
                    }
                }
            }
            for index in minusItemssArray{
                let i : Int = index as! Int
                if(indexPath.row == i){
                    var a : Int = Int((cell?.lblQuantity.text)!)!
                    a = a - 1
                    if(a == 0){
                        cell?.addView.isHidden = true
                        cell?.btnAdd.isHidden = false
                        addItemssArray.remove(indexPath.row)
                        minusItemssArray.remove(indexPath.row)
                        plusItemssArray.remove(indexPath.row)
                        showCartView()
                    }
                    cell?.lblQuantity.text = "\(a)"
                    if(a == 1){
                        cell?.btnDelete.setTitle("", for: .normal)
                        cell?.btnDelete.setImage(UIImage.init(named: "delete"), for: .normal)
                    }
                }
            }
            return cell!
        }
    }
    
    func showCartView ()  {
        if(addItemssArray.count > 0){
            cartView.isHidden = false
            cartHeight.constant = 100
        } else {
            cartView.isHidden = true
            cartHeight.constant = 0
        }
        self.view.layoutIfNeeded()
    }
  
    //    ResDetailTabSectionDelegate
    func tabClicked(selectedTab: Int) {
                self.selectedTab = selectedTab
        selectedMenu = menuArray[selectedTab]
        itemsArray = selectedMenu.items.allObjects as! [Items]
        tblView.reloadData()
    }
    //    ResDetailHeaderDelegate
    func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    func infoClicked() {
        let vc = InfoVC.initViewController(restaurant: restaurant)
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func showLoginView() {
        appDelegateShared?.showLogin()
    }
    
    @objc func addClicked(_ sender: UIButton) {
           let item = itemsArray [sender.tag]
        if(item.customization_groups.allObjects.count > 0){
            blurView.isHidden = false
            blurView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            let vc = CustomizationVC.initViewController(item: item)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .custom
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        } else {
            addItemssArray.add(sender.tag)
            plusItemssArray.add(sender.tag)
            UIView.setAnimationsEnabled(false)
            tblView.beginUpdates()
            let indexPath = IndexPath(item: sender.tag, section: 1)
            tblView.reloadRows(at: [indexPath], with: .automatic)
            tblView.endUpdates()
            showCartView()
        }
    }
    
    @objc func plusClicked(_ sender: UIButton) {
        plusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 1)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    
    @objc func deleteClicked(_ sender: UIButton) {
        minusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 1)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    
//    CustomizeDelegate
    func closeCustomizeView() {
        blurView.isHidden = true
    }
    
    func updateClicked() {
        blurView.isHidden = true
    }
}
