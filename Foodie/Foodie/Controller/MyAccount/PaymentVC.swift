

import UIKit

class PaymentVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
     @IBOutlet weak var tblView: UITableView!
    
    class func initViewController() -> PaymentVC {
        let vc = PaymentVC.init(nibName: "PaymentVC", bundle: nil)
        vc.title = "Payment"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        tblView.tableFooterView = UIView()
       
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Wallet"
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell") as? PaymentCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("PaymentCell", owner: self, options: nil)
            cell = nib?[0] as? PaymentCell
        }
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        
    }


}
