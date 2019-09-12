
import UIKit
import SnapKit

class MyAccountViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, EditAccountDelegate {
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet var footerView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tblViewTop: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    
    var rouCount = Int()
    var isHeaderSelected = Bool()
    
    class func initViewController() -> MyAccountViewController {
        let vc = MyAccountViewController.init(nibName: "MyAccountViewController", bundle: nil)
        vc.title = "My Account"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isBackButtonHidden = true
        rouCount = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blurView.isHidden = true
        UIApplication.shared.statusbarView?.backgroundColor = .clear
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        tblView.sectionHeaderHeight = UITableView.automaticDimension
        tblView.estimatedSectionHeaderHeight = 80
        tblView.tableHeaderView = headerView
        tblView.tableFooterView = footerView
        tblViewTop.constant = 0
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        blurView.isHidden = true
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
        }
    }
    
    @IBAction func editClicked(_ sender: Any) {
        blurView.isHidden = false
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let vc = EditAccountVC.initViewController()
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        //vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return rouCount
        } else if(section == 1){
            return 0
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 2){
            return 50
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 2){
            if(indexPath.row == 3){
                return 44
            }
            return UITableView.automaticDimension
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 2){
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 50))
            let lblTitle = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: tblView.frame.width, height: 50))
            lblTitle.text = "Past Orders"
            lblTitle.font = UIFont.init(name: "Helvetica Bold", size: 12)
            lblTitle.textColor = .lightGray
            view.backgroundColor = .groupTableViewBackground
            view.addSubview(lblTitle)
            return view
        }
        let view : AccountHeader = AccountHeader.instanceFromNib() as! AccountHeader
        view.setData(section: section, isHeaderSelected: isHeaderSelected)
        view.btnHeader.tag = section
        view.btnHeader.addTarget(self, action: #selector(headerClicked(_:)), for: .touchUpInside)
        return view
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 2){
            if(indexPath.row == 3){
                var cell = tableView.dequeueReusableCell(withIdentifier: "PastOrderButtonCell") as? PastOrderButtonCell
                if cell == nil {
                    var nib = Bundle.main.loadNibNamed("PastOrderButtonCell", owner: self, options: nil)
                    cell = nib?[0] as? PastOrderButtonCell
                }
                cell?.selectionStyle = .none
                return cell!
            }
            var cell = tableView.dequeueReusableCell(withIdentifier: "PastOrderCell") as? PastOrderCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("PastOrderCell", owner: self, options: nil)
                cell = nib?[0] as? PastOrderCell
            }
            cell?.selectionStyle = .none
            return cell!
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell") as? AccountCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("AccountCell", owner: self, options: nil)
            cell = nib?[0] as? AccountCell
        }
        cell?.selectionStyle = .none
        cell?.setData(index: indexPath.row)
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                let vc = ManageAddressVC.initViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }  else if(indexPath.row == 1){
                let vc = PaymentVC.initViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if(indexPath.row == 2){
                let vc = FavouritesVC.initViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if(indexPath.row == 3){
                let vc = ReferralsVC.initViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if(indexPath.row == 4){
                let vc = OffersVC.initViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func headerClicked(_ sender: UIButton) {
        if(sender.tag == 0){
            if(isHeaderSelected == true){
                sender.isSelected = false
                isHeaderSelected = false
                rouCount = 0
            } else {
                sender.isSelected = true
                isHeaderSelected = true
                rouCount = 5
            }
            tblView.reloadData()
        } else {
            let vc = HelpVC.initViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //    EditAccountDelegate
    
    func closeEditView() {
        blurView.isHidden = true
    }
    
    func updateAccount() {
        blurView.isHidden = true
    }
}
