

import UIKit

class CityVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    class func initViewController() -> CityVC {
        let vc = CityVC.init(nibName: "CityVC", bundle: nil)
        vc.title = "City"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       searchView.dropShadow()
        tblView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as? CityCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("CityCell", owner: self, options: nil)
            cell = nib?[0] as? CityCell
        }
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        
    }
}
extension UIView {
    
    func dropShadow() {
        self.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.40
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
    }
}

