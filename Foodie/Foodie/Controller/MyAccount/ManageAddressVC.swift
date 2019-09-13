
import UIKit

class ManageAddressVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    class func initViewController() -> ManageAddressVC {
        let vc = ManageAddressVC.init(nibName: "ManageAddressVC", bundle: nil)
        vc.title = "Manage Addresses"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 100
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Saved Addresses" 
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 60))
        let btn = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: tblView.frame.width - 20, height: 40))
        btn.setTitle( "Add New Address", for: .normal)
        btn.titleLabel!.font = UIFont.init(name: "Calibri-Bold", size: 16)
        btn.setTitleColor(appGreenColor, for: .normal)
        btn.layer.borderWidth = 2
        btn.layer.borderColor = appGreenColor.cgColor
        btn.addTarget(self, action: #selector(addClicked(_:)), for: .touchUpInside)
        view.addSubview(btn)
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ManageAddressCell") as? ManageAddressCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("ManageAddressCell", owner: self, options: nil)
            cell = nib?[0] as? ManageAddressCell
        }
        cell?.selectionStyle = .none
       
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addClicked(_ sender: Any) {
        
    }
}
