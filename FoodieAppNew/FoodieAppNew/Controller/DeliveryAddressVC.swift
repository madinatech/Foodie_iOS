

import UIKit
import MagicalRecord

@objc protocol DeliveryAddressDelegate {
    func selectedAddress(address: Address)
}

class DeliveryAddressVC: UIViewController, UITableViewDelegate, UITableViewDataSource , UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var topView: UIView!
    var selectedAddress = Address()
    var addressArray = [Address]()
    var delegate :  DeliveryAddressDelegate? = nil
    
    class func initViewController(selectedAddress: Address) -> DeliveryAddressVC {
        let vc = DeliveryAddressVC.init(nibName: "DeliveryAddressVC", bundle: nil)
        vc.selectedAddress = selectedAddress
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        loadArreass()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadArreass()
    }
    
    func loadArreass ()  {
  
            let account = AccountManager.instance().activeAccount
            addressArray = Address.getUserAddress(userID: Int(account?.user_id ?? "") ?? 0)
            if(addressArray.count > 0){
                tblView.reloadData()
            } else {
                tblView.isHidden = true
            }
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewAddressClicked(_ sender: Any) {
        let vc = AddNewAddressVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArray.count
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
        let address = addressArray[indexPath.row]
        cell?.setData(address: address)
        cell?.btnRadio.isSelected = false
        if(address == selectedAddress){
            cell?.btnRadio.isSelected = true
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        let address = addressArray[indexPath.row]
        let cell : ManageAddressCell = tblView.cellForRow(at: indexPath) as! ManageAddressCell
        if(cell.btnRadio.isSelected == true){
            cell.btnRadio.isSelected = false
        } else {
            cell.btnRadio.isSelected = true
        }
        for add in addressArray{
            if (add.entity_id == address.entity_id){
                address.is_selected = true
            } else {
                address.is_selected = false
            }
        }
        
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.selectedAddress(address: address)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let whitespace = Utils.whitespaceString(width: 100)
        let delete = UITableViewRowAction.init(style: .default, title: whitespace) { (action, indexPath) in
            print("delete item")
            let address = self.addressArray[indexPath.row]
            self.deleteAddress(address: address)
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
    
    func deleteAddress (address: Address)  {
        address.deleteAddress { (reponse, errorMessage) -> (Void) in
            if(errorMessage.count > 0){
                Utils.showAlert(withMessage: errorMessage)
            } else {
                MagicalRecord.save(blockAndWait: { (localContext:NSManagedObjectContext) in
                    address.mr_deleteEntity(in: localContext)
                })
               
                let account = AccountManager.instance().activeAccount
                self.addressArray = Address.getUserAddress(userID: Int(account?.user_id ?? "") ?? 0)
                self.tblView.reloadData()
            }
        }
    }
    
    @IBAction func optionClicked(_ sender: UIButton) {
        selectedAddress = self.addressArray[sender.tag]
        if(sender.isSelected == true){
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        tblView.reloadData()
        
        for add in addressArray{
            if (add.entity_id == selectedAddress.entity_id){
                selectedAddress.is_selected = true
            } else {
                selectedAddress.is_selected = false
            }
        }
        
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.selectedAddress(address: self.selectedAddress)
            }
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
