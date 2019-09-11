

import UIKit

class AreaVC: BaseViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    class func initViewController() -> AreaVC {
        let vc = AreaVC.init(nibName: "AreaVC", bundle: nil)
        vc.title = "Area"
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 50))
        let lblName = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: self.view.frame.width, height: 50))
        lblName.text = "D"
        lblName.textColor = appThemeColor
        view.addSubview(lblName)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as? CityCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("CityCell", owner: self, options: nil)
            cell = nib?[0] as? CityCell
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        
    }
}
