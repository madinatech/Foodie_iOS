
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
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 230
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
