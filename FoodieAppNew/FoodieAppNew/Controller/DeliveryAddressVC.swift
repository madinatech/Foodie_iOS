

import UIKit

class DeliveryAddressVC: UIViewController, UITableViewDelegate, UITableViewDataSource , UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var innerView: UIView!
    var selectdButton = Int()
    
    class func initViewController() -> DeliveryAddressVC {
        let vc = DeliveryAddressVC.init(nibName: "DeliveryAddressVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 102
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        tblView.isHidden = true
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }

  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ManageAddressCell") as? ManageAddressCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("ManageAddressCell", owner: self, options: nil)
            cell = nib?[0] as? ManageAddressCell
        }
        cell?.selectionStyle = .none
        cell?.btnRadio.tag = indexPath.row
        cell?.btnRadio.addTarget(self, action: #selector(optionClicked(_:)), for: .touchUpInside)
        cell?.btnRadio.isSelected = false
        if(indexPath.row == selectdButton){
            cell?.btnRadio.isSelected = true
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        let cell : ManageAddressCell = tblView.cellForRow(at: indexPath) as! ManageAddressCell
        if(cell.btnRadio.isSelected == true){
            cell.btnRadio.isSelected = false
        } else {
        cell.btnRadio.isSelected = true
        }
//        cell.accessoryType = .checkmark
//        cell.tintColor = appThemeColor
//        cell.innerView.backgroundColor = .lightGray
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func optionClicked(_ sender: UIButton) {
        selectdButton = sender.tag
        if(sender.isSelected == true){
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        tblView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
  

}
