
import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lblTime1: UILabel!
    @IBOutlet weak var lblTime2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setdata (index : Int)  {
        lblTime1.isHidden = false
        lblTime2.isHidden = false
        if(index == 0){
         lblTitle.text = "Opening Hours"
            self.contentView.layer.cornerRadius = 20
            self.contentView.clipsToBounds = true
            self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if(index == 1){
           lblTitle.text = "Takeaway Hours"
        }
//        else {
//            lblTitle.text = "Payment Methods"
//            lbl1.text = "Cash on delivery"
//            lbl2.text = "Pay with Tigo pesa"
//            lblTime1.isHidden = true
//            lblTime2.isHidden = true
//        }
    }
}
