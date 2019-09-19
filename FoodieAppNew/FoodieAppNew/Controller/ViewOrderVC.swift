

import UIKit

class ViewOrderVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnPickup: KGRadioButton!
    @IBOutlet weak var btnDine: KGRadioButton!
    @IBOutlet weak var btnDelivery: KGRadioButton!
    
    class func initViewController() -> ViewOrderVC {
        let vc = ViewOrderVC.init(nibName: "ViewOrderVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tblView.tableFooterView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        btnDine.isSelected = false
        btnDelivery.isSelected = true
        btnPickup.isSelected = false
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func doneInClicked(_ sender: Any) {
        btnDine.isSelected = true
        btnDelivery.isSelected = false
        btnPickup.isSelected = false
    }
    @IBAction func deliveryClicked(_ sender: Any) {
        btnDine.isSelected = false
        btnDelivery.isSelected = true
        btnPickup.isSelected = false
    }
    
    @IBAction func pickupClicked(_ sender: Any) {
        btnDine.isSelected = false
        btnDelivery.isSelected = false
        btnPickup.isSelected = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        } else if (section == 1)  {
            return 2
        } else {
            return 1
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if(indexPath.section == 0){
//             UITableView.automaticDimension
//        }
        if(indexPath.section == 2){
            return 470
        }
        return UITableView.automaticDimension
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "ViewOrderTopCell") as? ViewOrderTopCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("ViewOrderTopCell", owner: self, options: nil)
                cell = nib?[0] as? ViewOrderTopCell
            }
            cell?.selectionStyle = .none
          
            return cell!
        } else  if(indexPath.section == 1){
            var cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell") as? ItemsCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("ItemsCell", owner: self, options: nil)
                cell = nib?[0] as? ItemsCell
            }
            cell?.selectionStyle = .none
           
            return cell!
            
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "ViewOrderMoreCell") as? ViewOrderMoreCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("ViewOrderMoreCell", owner: self, options: nil)
                cell = nib?[0] as? ViewOrderMoreCell
            }
            cell?.selectionStyle = .none
            return cell!
            
        }
    }
}
