

import UIKit

class PastOrderCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
       tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 44
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setData ()  {
        tblViewHeight.constant = tblView.contentSize.height
        self.layoutIfNeeded()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "PastOrederSubCell") as? PastOrederSubCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("PastOrederSubCell", owner: self, options: nil)
            cell = nib?[0] as? PastOrederSubCell
        }
        cell?.selectionStyle = .none
        
        return cell!
        
    }
    
}
