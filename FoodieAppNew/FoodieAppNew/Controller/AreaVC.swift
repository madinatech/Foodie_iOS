

import UIKit

class AreaVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
   
    @IBOutlet weak var tblView: UITableView!
    var city = City()
     var areaArray = [Area]()
    class func initViewController(city: City) -> AreaVC {
        let vc = AreaVC.init(nibName: "AreaVC", bundle: nil)
        vc.city = city
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        areaArray = city.areas.allObjects as! [Area]
        self.areaArray = areaArray.sorted(by: {
            ($0.name!.localizedLowercase) <
                ($1.name!.localizedLowercase)
        } )
        tblView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //    func numberOfSections(in tableView: UITableView) -> Int {
//        return 5
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaArray.count
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as? CityCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("CityCell", owner: self, options: nil)
            cell = nib?[0] as? CityCell
        }
        cell?.selectionStyle = .none
        let area : Area = areaArray[indexPath.row]
        cell?.lblName.text = area.name
        cell?.imagWidth.constant = 0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        for ar in areaArray{
            ar.is_selected = false
        }
        let area : Area = areaArray[indexPath.row]
        area.is_selected = true
        self.navigationController?.popToRootViewController(animated: true)
    }
}
