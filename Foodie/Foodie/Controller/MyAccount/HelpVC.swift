

import UIKit

class HelpVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var sectionArray = [String]()
    class func initViewController() -> HelpVC {
        let vc = HelpVC.init(nibName: "HelpVC", bundle: nil)
        vc.title = "Help"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        tblView.tableFooterView = UIView()
        sectionArray = ["General issues", "Legal, Terms & Conditions", "FAQs"]
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        } else if(section == 1){
            return sectionArray.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Recent Order"
        } else if(section == 1){
            return "Help with other queries"
        } else {
            return "Conversation Archive"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
        return UITableView.automaticDimension
        } else {
            return 50
        }        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "RecentOrderCell") as? RecentOrderCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("RecentOrderCell", owner: self, options: nil)
                cell = nib?[0] as? RecentOrderCell
            }
            cell?.selectionStyle = .none
            
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "HelpCell") as? HelpCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("HelpCell", owner: self, options: nil)
                cell = nib?[0] as? HelpCell
            }
            cell?.selectionStyle = .none
            cell?.accessoryType = .disclosureIndicator
            if(indexPath.section == 1){
                cell?.lblTitle.text = sectionArray[indexPath.row]
            } else {
                cell?.lblTitle.text = "All Conversation threads"
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        
    }

}
