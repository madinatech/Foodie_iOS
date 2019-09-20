

import UIKit

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource , SearchCategoryCellDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var btnRestaurnat: UIButton!
    @IBOutlet weak var btnDishes: UIButton!
    @IBOutlet weak var filterViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var innerView: UIView!
    var cellHeight = CGFloat()
    var isLoded = Bool()
    var isSearch = Bool()
    
    class func initViewController() -> SearchVC {
        let vc = SearchVC.init(nibName: "SearchVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tblView.tableFooterView = UIView()
        cellHeight = 130
        isLoded = false
        txtSearch.attributedPlaceholder = NSAttributedString(string: "Search for a dish or restaurant",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        restaurantClicked(btnRestaurnat)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterViewHeight.constant = 0
        filterView.isHidden = true
        self.view.layoutIfNeeded()
    }
    
    
    @IBAction func restaurantClicked(_ sender: UIButton) {
        btnRestaurnat.isSelected = true
        btnDishes.isSelected = false
        btnRestaurnat.backgroundColor = appThemeColor
        btnDishes.backgroundColor = appLightThemeColor
    }
    
    @IBAction func dishesClicked(_ sender: Any) {
        btnRestaurnat.isSelected = false
        btnDishes.isSelected = true
        btnRestaurnat.backgroundColor = appLightThemeColor
        btnDishes.backgroundColor = appThemeColor
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(isSearch == true){
            return 1
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearch == true){
            return 10
        } else {
            if(section == 0){
                return 3
            }
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.white
        let lblTitle = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: tblView.frame.width - 10, height: 50))
        lblTitle.font = UIFont.init(name: "Calibri-Bold", size: 18)
        
        if(section == 0){
            lblTitle.text = "Recent Searches"
        } else {
            lblTitle.text = "Cuisines"
        }
        headerView.addSubview(lblTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(isSearch == true){
            return 110
        } else {
            if(indexPath.section == 0){
                return 44
            } else {
                return cellHeight//UITableView.automaticDimension
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(isSearch == true){
            return 0
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(isSearch == true){
            var cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as? RestaurantCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("RestaurantCell", owner: self, options: nil)
                cell = nib?[0] as? RestaurantCell
            }
            cell?.selectionStyle = .none
            return cell!
        } else {
            if(indexPath.section == 0){
                var cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell") as? RecentSearchCell
                if cell == nil {
                    var nib = Bundle.main.loadNibNamed("RecentSearchCell", owner: self, options: nil)
                    cell = nib?[0] as? RecentSearchCell
                }
                cell?.selectionStyle = .none
                return cell!
            }
            var cell = tableView.dequeueReusableCell(withIdentifier: "SearchCategoryCell") as? SearchCategoryCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("SearchCategoryCell", owner: self, options: nil)
                cell = nib?[0] as? SearchCategoryCell
            }
            cell?.selectionStyle = .none
            cell?.delegate = self
            if(isLoded == false){
                cell?.setHeight()
            }
            return cell!
        }
    }
    
    func updateHeight(height: CGFloat) {
        print("UUUUU \(height)")
        isLoded = true
        cellHeight = 700//height
        tblView.reloadData()
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        if(replacedText.count > 0){
            imgSearch.image = UIImage.init(named: "Search_red")
            searchView.backgroundColor = appLigtGrayColor
            txtSearch.attributedPlaceholder = NSAttributedString(string: "Search for a dish or restaurant",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            innerView.backgroundColor = appLigtGrayColor
            self.view.backgroundColor = .white
            filterViewHeight.constant = 40
            filterView.isHidden = false
            isSearch = true
            self.view.layoutIfNeeded()
        } else {
            imgSearch.image = UIImage.init(named: "Search_white")
            searchView.backgroundColor = UIColor.init(red: 181.0/255.0, green: 12.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            txtSearch.attributedPlaceholder = NSAttributedString(string: "Search for a dish or restaurant",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            innerView.backgroundColor = .white
            self.view.backgroundColor = appThemeColor
            filterViewHeight.constant = 0
            filterView.isHidden = true
            isSearch = false
            self.view.layoutIfNeeded()
        }
        tblView.reloadData()
        
        return true
    }
}
