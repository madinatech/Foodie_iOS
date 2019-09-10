

import UIKit

class MoreVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    var titleArray = [String]()
    
    class func initViewController() -> MoreVC {
        let vc = MoreVC.init(nibName: "MoreVC", bundle: nil)
        vc.title = "More"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        titleArray = ["Log In or Create Account", "Settings", "About", "Live chat"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as? CityCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("CityCell", owner: self, options: nil)
            cell = nib?[0] as? CityCell
        }
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        cell?.lblName.text = titleArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        if(indexPath.row == 0){
            let vc = LoginVc.initViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if(indexPath.row == 1){
           
        } else if(indexPath.row == 2){
            let vc = AboutVc.initViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }  else if(indexPath.row == 3){
            
        }
        
    }
}
