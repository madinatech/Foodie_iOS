

import UIKit

@objc protocol CustomizeDelegate {
    func closeCustomizeView()
    func updateClicked()
}

class CustomizationVC: UIViewController , UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    
    var delegate :  CustomizeDelegate? = nil
    var checkedArray = NSMutableArray()
    var item = Items()
    var customizationGroupArray = [CustomizationGroup]()
    var groupValueArray = [GroupValues]()
    var selectedGroupValue = GroupValues()
    
    class func initViewController(item : Items) -> CustomizationVC {
        let vc = CustomizationVC.init(nibName: "CustomizationVC", bundle: nil)
        vc.item = item
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tblView.tableFooterView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        tapView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.closeCustomizeView()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizationGroupArray = item.customization_groups.allObjects as! [CustomizationGroup]
        tblView.reloadData()
        showData()
    }
    
    func showData()  {
        lblItemName.text = item.name
        let priceArray : [Price] = item.price.allObjects as! [Price]
        if(priceArray.count > 0){
            let price : Price = priceArray[0]
            lblPrice.text = "TZS \(price.price)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tblView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return customizationGroupArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupValueArray = customizationGroupArray[section].group_values.allObjects as! [GroupValues]
        return groupValueArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return customizationGroupArray[section].group_name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customize : CustomizationGroup = customizationGroupArray[indexPath.section]
        if(customize.group_type_code == "2") {
            var cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeSingleCell") as? CustomizeSingleCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CustomizeSingleCell", owner: self, options: nil)
                cell = nib?[0] as? CustomizeSingleCell
            }
            cell?.selectionStyle = .none
            cell?.btnRedio.tag = indexPath.row
            cell?.btnRedio.addTarget(self, action: #selector(radioClicked(_:)), for: .touchUpInside)
            cell?.btnRedio.isSelected = false
            
            groupValueArray = customizationGroupArray[indexPath.section].group_values.allObjects as! [GroupValues]
            let groupValue = groupValueArray[indexPath.row]
            cell?.setData(value: groupValue)
            if(groupValue == selectedGroupValue){
                cell?.btnRedio.isSelected = true
            }
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeCell") as? CustomizeCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CustomizeCell", owner: self, options: nil)
                cell = nib?[0] as? CustomizeCell
            }
            cell?.selectionStyle = .none
            cell?.btnCheck.tag = indexPath.row
            cell?.btnCheck.addTarget(self, action: #selector(optionClicked(_:)), for: .touchUpInside)
            
            
            groupValueArray = customizationGroupArray[indexPath.section].group_values.allObjects as! [GroupValues]
            let groupValue = groupValueArray[indexPath.row]
            cell?.setData(value: groupValue)
            
            cell?.btnCheck.isSelected = false
            if(checkedArray.contains(groupValue)){
                cell?.btnCheck.isSelected = true
            }
            return cell!
        }
    }
    
    @objc func optionClicked(_ sender: UIButton) {
        let groupValue =  groupValueArray[sender.tag]
        if(checkedArray.contains(groupValue)){
            checkedArray.remove(groupValue)
        } else {
            checkedArray.add(groupValue)
        }
        tblView.reloadData()
    }
    
    @objc func radioClicked(_ sender: UIButton) {
        selectedGroupValue = groupValueArray[sender.tag]
        tblView.reloadData()
    }
    
    @IBAction func closeClicked(_ sender: UIButton) {
        
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.closeCustomizeView()
            }
        }
    }
    
    @IBAction func updateClicked(_ sender: UIButton) {
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.closeCustomizeView()
            }
        }
    }
}
