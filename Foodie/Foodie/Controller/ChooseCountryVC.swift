
import UIKit

class ChooseCountryVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblView: UITableView!
    var selectedIndex = Int()
    
    class func initViewController() -> ChooseCountryVC {
        let vc = ChooseCountryVC.init(nibName: "ChooseCountryVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tblView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("CountryCell", owner: self, options: nil)
            cell = nib?[0] as? CountryCell
        }
        cell?.selectionStyle = .none
        cell?.btnView.tag = indexPath.row
        cell?.btnView.addTarget(self, action: #selector(optionClicked(_:)), for: .touchUpInside)
        cell?.btnView.isSelected = false
        if(indexPath.row == selectedIndex){
            cell?.btnView.isSelected = true
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        tblView.reloadData()
        navigatetoDeliveryLocation()
    }
    
    @IBAction func optionClicked(_ sender: UIButton) {
        sender.isSelected = true
        selectedIndex = sender.tag
        tblView.reloadData()
        navigatetoDeliveryLocation()
    }
    
    func navigatetoDeliveryLocation ()  {
        appDelegateShared?.showTabbar()
//        let vc = DeliveryLoactionVC.initViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
