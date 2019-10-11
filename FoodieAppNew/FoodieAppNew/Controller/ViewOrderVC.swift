

import UIKit

class ViewOrderVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnPickup: KGRadioButton!
    @IBOutlet weak var btnDine: KGRadioButton!
    @IBOutlet weak var btnDelivery: KGRadioButton!
    
    var cart  = Cart()
    var itemsArray = [LocalCart]()
    
    class func initViewController(cart : Cart) -> ViewOrderVC {
        let vc = ViewOrderVC.init(nibName: "ViewOrderVC", bundle: nil)
        vc.cart = cart
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
        topView.addGestureRecognizer(tap)
        btnDine.isSelected = false
        btnDelivery.isSelected = true
        btnPickup.isSelected = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemsArray = cart.cart_item.allObjects as! [LocalCart]
        tblView.reloadData()
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
            return itemsArray.count
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
                let nib = Bundle.main.loadNibNamed("ViewOrderTopCell", owner: self, options: nil)
                cell = nib?[0] as? ViewOrderTopCell
            }
            cell?.selectionStyle = .none
            cell?.showData(cart: cart)
            return cell!
        } else if(indexPath.section == 1){
            var cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell") as? ItemsCell
            if cell == nil {
                let nib = Bundle.main.loadNibNamed("ItemsCell", owner: self, options: nil)
                cell = nib?[0] as? ItemsCell
            }
            cell?.selectionStyle = .none
            let item : LocalCart = itemsArray[indexPath.row]
            cell?.showData(item: item)
            cell?.btnDelete.tag = indexPath.row
            cell?.btnPlus.tag = indexPath.row
             cell?.btnPlus.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
             cell?.btnDelete.addTarget(self, action: #selector(deleteClicked), for: .touchUpInside)
            return cell!
            
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "ViewOrderMoreCell") as? ViewOrderMoreCell
            if cell == nil {
                let nib = Bundle.main.loadNibNamed("ViewOrderMoreCell", owner: self, options: nil)
                cell = nib?[0] as? ViewOrderMoreCell
            }
            cell?.selectionStyle = .none
            cell?.btnAddDishes.addTarget(self, action: #selector(addDishesClicked(_:)), for: .touchUpInside)
            return cell!
            
        }
    }
    
    @objc func addDishesClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteClicked(_ sender: UIButton) {
            let item : LocalCart = itemsArray[sender.tag]
            removeItemsToCart(item: item)
        
        if(item.item_quantity == 0){
                   item.removeEntity()
                   cart.removeCart_itemObject(item)
                   itemsArray = cart.cart_item.allObjects as! [LocalCart]
                   tblView.reloadData()
               } else {
                 UIView.setAnimationsEnabled(false)
                                       let indexPath = IndexPath(item: sender.tag, section: 1)
                                       tblView.beginUpdates()
                                       tblView.moveRow(at: indexPath, to: indexPath)
                                       tblView.endUpdates()
                                       tblView.reloadRows(at: [indexPath], with: .automatic)
               }
        }
    
    
    @objc func addClicked(_ sender: UIButton) {
        let item : LocalCart = itemsArray[sender.tag]
        addItemsToCart(item: item)
        UIView.setAnimationsEnabled(false)
                  let indexPath = IndexPath(item: sender.tag, section: 1)
                  tblView.beginUpdates()
                  tblView.moveRow(at: indexPath, to: indexPath)
                  tblView.endUpdates()
                  tblView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func addItemsToCart (item : LocalCart)  {
        cart.total_items = cart.total_items + 1
        cart.total_amount = cart.total_amount + item.item_price
//        item.item_price = item.item_price + (item.item_price / item.item_quantity)
         item.item_quantity = item.item_quantity + 1
        item.saveEntity()
        cart.saveEntity()
    }
    
    func removeItemsToCart (item : LocalCart)  {
        cart.total_items = cart.total_items - 1
        cart.total_amount = cart.total_amount - item.item_price
        
//        item.item_price = item.item_price - (item.item_price / item.item_quantity)
        item.item_quantity = item.item_quantity - 1
        if(cart.total_items == 0){
            Cart.removeEntity()
            self.dismiss(animated: true, completion: nil)
        }
        
       
         item.saveEntity()
        cart.saveEntity()
    
    }
}
