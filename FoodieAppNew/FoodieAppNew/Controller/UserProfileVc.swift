
import UIKit

class UserProfileVc: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var innerView: UIView!
    class func initViewController() -> UserProfileVc {
        let vc = UserProfileVc.init(nibName: "UserProfileVc", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  tblView.tableFooterView = UIView()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.clear
        let lblTitle = UILabel.init(frame: CGRect.init(x: 15, y: 25, width: tblView.frame.width - 30, height: 1))
      lblTitle.backgroundColor = .lightGray
        headerView.addSubview(lblTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return  44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("ProfileCell", owner: self, options: nil)
                cell = nib?[0] as? ProfileCell
            }
            cell?.selectionStyle = .none
            cell?.setData(index: indexPath.row, section: indexPath.section)
        cell?.accessoryType = .disclosureIndicator
            return cell!
       
    }
}
