

import UIKit

class CartVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, CustomizeDelegate {
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var btnBrowse: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewTop: NSLayoutConstraint!
    @IBOutlet weak var payViewBottom: NSLayoutConstraint!
    
    var plusItemssArray = NSMutableArray()
    var minusItemssArray = NSMutableArray()
    
    class func initViewController() -> CartVC {
        let vc = CartVC.init(nibName: "CartVC", bundle: nil)
        vc.title = "Gamthi Kathiyawadi"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        btnBrowse.layer.borderColor = appThemeColor.cgColor
        btnBrowse.layer.borderWidth = 1
        tblView.tableFooterView = UIView()
        tblView.tableHeaderView = headerView
            self.isBackButtonHidden = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusbarView?.backgroundColor = .clear
         self.tabBarController?.selectedIndex = 2
            self.tabBarController?.tabBar.isHidden = false
        blurView.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        tblView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(tabBarController?.tabBar.isHidden == false){
            payViewBottom.constant = -10
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(tblView.contentOffset.y)
        var offset = scrollView.contentOffset.y / 150
        if(offset > 1){
            offset = 1
            self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: offset)
            UIApplication.shared.statusbarView?.backgroundColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: offset)
        } else {
            self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: offset)
            UIApplication.shared.statusbarView?.backgroundColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: offset)
        }
        
        if(tblView.contentOffset.y > 0){
            self.navigationController?.navigationBar.isHidden = false
        } else {
            self.navigationController?.navigationBar.isHidden = true
            tblViewTop.constant = 0
        }
    }
    
    @IBAction func proceedToPayClicked(_ sender: Any) {
        let vc = PaymentVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func viewBillClicked(_ sender: Any) {
        let indexPath = NSIndexPath(row: 0, section: 2)
        tblView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
    
    @IBAction func browseClicked(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 3
        } else if(section == 1){
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            if(indexPath.row == 2){
                return 55
            } else {
                return UITableView.automaticDimension
            }
        } else if(indexPath.section == 1){
            return 60
        } else {
            return 240
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            if(indexPath.row == 2){
                var cell = tableView.dequeueReusableCell(withIdentifier: "CartRequestCell") as? CartRequestCell
                if cell == nil {
                    var nib = Bundle.main.loadNibNamed("CartRequestCell", owner: self, options: nil)
                    cell = nib?[0] as? CartRequestCell
                }
                cell?.selectionStyle = .none
                return cell!
            }
            var cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell") as? CartItemCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CartItemCell", owner: self, options: nil)
                cell = nib?[0] as? CartItemCell
            }
            cell?.selectionStyle = .none
            cell?.btnPlus.tag = indexPath.row
            cell?.btnMinus.tag = indexPath.row
            cell?.btnPlus.addTarget(self, action: #selector(plusClicked(_:)), for: .touchUpInside)
            cell?.btnMinus.addTarget(self, action: #selector(minusClicked(_:)), for: .touchUpInside)
            cell?.btnCustomize.addTarget(self, action: #selector(customizeClicked(_:)), for: .touchUpInside)
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
                    if(a < 1){
                        a = 1
                    }
                    if(a == 0){
                        minusItemssArray.remove(indexPath.row)
                        plusItemssArray.remove(indexPath.row)
                    }
                    cell?.lblItemCount.text = "\(a)"
                }
            }
            return cell!
        } else if(indexPath.section == 1){
            var cell = tableView.dequeueReusableCell(withIdentifier: "CoupanCell") as? CoupanCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CoupanCell", owner: self, options: nil)
                cell = nib?[0] as? CoupanCell
            }
            cell?.selectionStyle = .none
            cell?.setData(index: indexPath.row)
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "BillDetailCell") as? BillDetailCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("BillDetailCell", owner: self, options: nil)
                cell = nib?[0] as? BillDetailCell
            }
            cell?.selectionStyle = .none
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func plusClicked(_ sender: UIButton) {
        plusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    
    @IBAction func minusClicked(_ sender: UIButton) {
        minusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    @IBAction func customizeClicked(_ sender: UIButton) {
        blurView.isHidden = false
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let vc = CustomizeCartVC.initViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        
    }
    
    func closeCustomizeView() {
        blurView.isHidden = true
    }
    
    func updateClicked() {
        blurView.isHidden = true
    }
}
