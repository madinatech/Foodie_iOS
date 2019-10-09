
import UIKit

class OrderListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var innerView: UIView!
    class func initViewController() -> OrderListVC {
        let vc = OrderListVC.init(nibName: "OrderListVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 230
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 0
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0){
            let view : OrderHeaderView = OrderHeaderView.instanceFromNib() as! OrderHeaderView
            view.setData()
            return view
        } else {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 70))
            headerView.backgroundColor = appLigtGrayColor
          
            headerView.layer.cornerRadius = 20
            headerView.clipsToBounds = true
            headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            let lblTitle = UILabel.init(frame: CGRect.init(x: 10, y: 20, width: tblView.frame.width - 20, height: 30))
           lblTitle.text = "Past Orders"
            lblTitle.font = UIFont.init(name: "Montserrat-Regular", size: 25)
             headerView.addSubview(lblTitle)
            return headerView
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 1100//UITableView.automaticDimension
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "PastOrderCell") as? PastOrderCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("PastOrderCell", owner: self, options: nil)
            cell = nib?[0] as? PastOrderCell
        }
        cell?.selectionStyle = .none
        cell?.setData()
        return cell!
        
    }
    
    
}
