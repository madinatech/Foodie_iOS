

import UIKit

class OrderHeaderView: UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    var orderStatus = [String]()
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "OrderHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    func setData ()  {
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 40
        tblView.tableFooterView = UIView()
        orderStatus = ["Waiting for restaurant to accept order","Chef getting ready (only applicable in future order)","Preparing your food","Driver arrived","On the way","Delivered","Cancelled (Notes)"]

        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderStatus.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "OrderStatusCell") as? OrderStatusCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("OrderStatusCell", owner: self, options: nil)
            cell = nib?[0] as? OrderStatusCell
        }
        cell?.selectionStyle = .none
        cell?.lblStatus.text = orderStatus[indexPath.row]
        return cell!
        
    }
    
}
