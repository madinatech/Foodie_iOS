

import UIKit

class AboutVc: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var titleArray = [String]()
    
    class func initViewController() -> AboutVc {
        let vc = AboutVc.init(nibName: "AboutVc", bundle: nil)
        vc.title = "About"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        titleArray = ["How it works?", "Press", "Contact", "Terms and Conditions", "Privacy Policy"]
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
           
        } else if(indexPath.row == 1){
           
        } else if(indexPath.row == 2){
            
        } else if(indexPath.row == 3){
            let vc = TermsVC.initViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if(indexPath.row == 4){
            
        }
    }
}
