

import UIKit

@objc protocol FilterDelegate {
    func closeFilter()
    func applyFilter()
}
class FilterVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblViewMain: UITableView!
    @IBOutlet weak var tblViewSub: UITableView!
    @IBOutlet weak var applyView: UIView!
    @IBOutlet weak var subView: UIView!
    
    var selectedFilter = Int()
    var selectedSubFilter = Int()
    var mainArray = [String]()
    var filterArray = [String]()
    var selectedArry = NSMutableArray()
    var delegate :  FilterDelegate? = nil
    
    class func initViewController() -> FilterVC {
        let vc = FilterVC.init(nibName: "FilterVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyView.dropShadow()
        tblViewMain.tableFooterView = UIView()
        tblViewSub.tableFooterView = UIView()
        subView.layer.borderColor = appLigtGrayColor.cgColor
        subView.layer.borderWidth = 1
        tblViewMain.layer.borderColor = appLigtGrayColor.cgColor
        tblViewMain.layer.borderWidth = 1
        mainArray = ["Sort", "Cusines", "Offers & More"]
        filterArray = ["Relevance", "Cost for two", "Delivery time", "Rating"]
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.closeFilter()
            }
        }
    }
    
    @IBAction func applyClicked(_ sender: Any) {
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.applyFilter()
            }
        }
    }
    
    @IBAction func clearallClicked(_ sender: Any) {
        mainArray = ["Sort", "Cusines", "Offers & More"]
        filterArray = ["Relevance", "Cost for two", "Delivery time", "Rating"]
        selectedSubFilter = 0
        selectedFilter = 0
        selectedArry = NSMutableArray()
        tblViewMain.reloadData()
        tblViewSub.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblViewMain){
            return mainArray.count
        }
        return filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tblViewMain){
            var cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as? CityCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CityCell", owner: self, options: nil)
                cell = nib?[0] as? CityCell
            }
            cell?.selectionStyle = .none
            cell?.lblName.textColor = .lightGray
            if(indexPath.row == selectedFilter){
                cell?.contentView.backgroundColor = .white
            } else {
                cell?.contentView.backgroundColor = .groupTableViewBackground
            }
            cell?.lblName.text = mainArray[indexPath.row]
            return cell!
        }
        if(mainArray[selectedFilter] == "Sort"){
            var cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CountryCell", owner: self, options: nil)
                cell = nib?[0] as? CountryCell
            }
            cell?.selectionStyle = .none
            cell?.img.isHidden = true
            //            cell?.btnView.outerCircleColor = appThemeColor
            //            cell?.btnView.innerCircleCircleColor = appThemeColor
            cell?.btnView.tag = indexPath.row
            cell?.lblCountryName.text = filterArray[indexPath.row]
            cell?.btnView.addTarget(self, action: #selector(optionClicked(_:)), for: .touchUpInside)
            cell?.btnView.isSelected = false
            if(indexPath.row == selectedSubFilter){
                cell?.btnView.isSelected = true
            }
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as? FilterCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("FilterCell", owner: self, options: nil)
                cell = nib?[0] as? FilterCell
            }
            cell?.selectionStyle = .none
            cell?.btnCheck.tag = indexPath.row
            cell?.lblTitle.text = filterArray[indexPath.row]
            cell?.btnCheck.addTarget(self, action: #selector(checkboxClicked(_:)), for: .touchUpInside)
            cell?.btnCheck.isSelected = false
            if(selectedArry.contains(filterArray[indexPath.row])){
                cell?.btnCheck.isSelected = true
            }
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == tblViewMain){
            selectedFilter = indexPath.row
            if(mainArray[selectedFilter] == "Sort"){
                filterArray = ["Relevance", "Cost for two", "Delivery time", "Rating"]
            } else if(mainArray[indexPath.row] == "Cusines"){
                filterArray = ["American", "Bengali", "Gujarati", "Italian"]
            } else {
                filterArray = ["Offers", "Pure Veg"]
            }
        } else {
            if(mainArray[selectedFilter] == "Sort"){
                selectedSubFilter = indexPath.row
            } else {
                if(selectedArry.contains(filterArray[indexPath.row])){
                    selectedArry.remove(filterArray[indexPath.row])
                } else {
                    selectedArry.add(filterArray[indexPath.row])
                }
            }
        }
        tblViewMain.reloadData()
        tblViewSub.reloadData()
    }
    
    @IBAction func optionClicked(_ sender: UIButton) {
        sender.isSelected = true
        selectedSubFilter = sender.tag
        tblViewSub.reloadData()
    }
    
    @IBAction func checkboxClicked(_ sender: UIButton) {
        if(selectedArry.contains(filterArray[sender.tag])){
            selectedArry.remove(filterArray[sender.tag])
        } else {
            selectedArry.add(filterArray[sender.tag])
        }
        tblViewSub.reloadData()
    }
}
