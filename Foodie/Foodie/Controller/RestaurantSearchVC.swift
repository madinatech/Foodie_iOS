

import UIKit

@objc protocol RestaurantSearchDelegate {
    func cancleClicked()
}

class RestaurantSearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
    var delegate :  RestaurantSearchDelegate? = nil
    var addItemssArray = NSMutableArray()
    var plusItemssArray = NSMutableArray()
    var minusItemssArray = NSMutableArray()
    
    class func initViewController() -> RestaurantSearchVC {
        let vc = RestaurantSearchVC.init(nibName: "RestaurantSearchVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        search.showsCancelButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        search.becomeFirstResponder()
        UIApplication.shared.statusbarView?.backgroundColor = .clear
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.white
        let lblTitle = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: tblView.frame.width - 10, height: 50))
        lblTitle.font = UIFont.init(name: "Calibri-Bold", size: 16)
        if(section == 0){
            lblTitle.text = "Dal"
        } else {
            lblTitle.text = "Main Course"
        }
        
        headerView.addSubview(lblTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantDetailCell") as? RestaurantDetailCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("RestaurantDetailCell", owner: self, options: nil)
            cell = nib?[0] as? RestaurantDetailCell
        }
        cell?.selectionStyle = .none
        cell?.btnAdd.tag = indexPath.row
        cell?.btnPlus.tag = indexPath.row
        cell?.btnMinus.tag = indexPath.row
        cell?.btnAdd.addTarget(self, action: #selector(addClicked(_:)), for: .touchUpInside)
        cell?.btnPlus.addTarget(self, action: #selector(plusClicked(_:)), for: .touchUpInside)
        cell?.btnMinus.addTarget(self, action: #selector(minusClicked(_:)), for: .touchUpInside)
        cell?.addView.isHidden = true
        cell?.btnAdd.isHidden = false
        
        if(addItemssArray.contains(indexPath.row)){
            cell?.btnAdd.isHidden = true
            cell?.addView.isHidden = false
            cell?.lblItemCount.text = "0"
        }
        
        for index in plusItemssArray{
            let i : Int = index as! Int
            if(indexPath.row == i){
                var a : Int = Int((cell?.lblItemCount.text)!)!
                a = a + 1
                cell?.lblItemCount.text = "\(a)"
            }
        }
        for index in minusItemssArray{
            let i : Int = index as! Int
            if(indexPath.row == i){
                var a : Int = Int((cell?.lblItemCount.text)!)!
                a = a - 1
                if(a == 0){
                    cell?.addView.isHidden = true
                    cell?.btnAdd.isHidden = false
                    addItemssArray.remove(indexPath.row)
                    minusItemssArray.remove(indexPath.row)
                    plusItemssArray.remove(indexPath.row)
                }
                cell?.lblItemCount.text = "\(a)"
            }
        }
        return cell!
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        addItemssArray.add(sender.tag)
        plusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 1)
        tblView.reloadRows(at: [indexPath], with: .automatic)
        tblView.endUpdates()
    }
    
    @IBAction func plusClicked(_ sender: UIButton) {
        plusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 1)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    
    @IBAction func minusClicked(_ sender: UIButton) {
        minusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 1)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    
    //    UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        search.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search.endEditing(true)
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.cancleClicked()
            }
        }
    }
    
}
