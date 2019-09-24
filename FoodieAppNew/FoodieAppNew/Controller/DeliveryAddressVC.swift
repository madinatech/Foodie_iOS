

import UIKit

class DeliveryAddressVC: UIViewController, UITableViewDelegate, UITableViewDataSource , UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var topView: UIView!
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
        topView.addGestureRecognizer(tap)
//        tblView.isHidden = true
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
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete){
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let whitespace = Utils.whitespaceString(width: 100)
        let delete = UITableViewRowAction.init(style: .default, title: whitespace) { (action, indexPath) in
            print("delete item")
            
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 110))
        let innerView = UIView(frame: CGRect(x: 5, y: 10, width: 60, height: 85))
        view.backgroundColor = appLigtGrayColor
        innerView.backgroundColor = .white
        innerView.layer.cornerRadius = 10
        let imageView = UIImageView(frame: CGRect(x: 15, y: 30, width: 25, height: 25))
        imageView.image = UIImage(named: "deleteIcon")
        innerView.addSubview(imageView)
        view.addSubview(innerView)
        let image = view.image()
        delete.backgroundColor = UIColor.init(patternImage: image)
        return [delete]
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
