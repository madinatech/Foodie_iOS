
import UIKit

@objc protocol CustomizeDelegate {
    func closeCustomizeView()
    func updateClicked()
}

class CustomizeCartVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    var delegate :  CustomizeDelegate? = nil
    var checkedArray = NSMutableArray()
    
    class func initViewController() -> CustomizeCartVC {
        let vc = CustomizeCartVC.init(nibName: "CustomizeCartVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewHeight.constant = tblView.contentSize.height
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewHeight.constant = tblView.contentSize.height
        self.view.layoutIfNeeded()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        } else if(section == 1){
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return UITableView.automaticDimension
        } else if(indexPath.section == 1){
            return 40
        } else {
            return 100
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 1){
            return 50
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 1){
            return "Add Ons(1)"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeItemCell") as? CustomizeItemCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CustomizeItemCell", owner: self, options: nil)
                cell = nib?[0] as? CustomizeItemCell
            }
            cell?.selectionStyle = .none
            cell?.btnCose.addTarget(self, action: #selector(closeClicked(_:)), for: .touchUpInside)
            return cell!
            
        } else if(indexPath.section == 1){
            var cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeCell") as? CustomizeCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CustomizeCell", owner: self, options: nil)
                cell = nib?[0] as? CustomizeCell
            }
            cell?.selectionStyle = .none
            cell?.btnCheck.tag = indexPath.row
            cell?.btnCheck.addTarget(self, action: #selector(optionClicked(_:)), for: .touchUpInside)
            cell?.btnCheck.isSelected = false
            if(checkedArray.contains(indexPath.row)){
                cell?.btnCheck.isSelected = true
            }
            
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeTotalCell") as? CustomizeTotalCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CustomizeTotalCell", owner: self, options: nil)
                cell = nib?[0] as? CustomizeTotalCell
            }
            cell?.selectionStyle = .none
            cell?.btnUpdateItem.addTarget(self, action: #selector(updateClicked(_:)), for: .touchUpInside)
            return cell!
        }
    }
    
    @IBAction func optionClicked(_ sender: UIButton) {
        if(checkedArray.contains(sender.tag)){
            checkedArray.remove(sender.tag)
        } else {
            checkedArray.add(sender.tag)
        }
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
