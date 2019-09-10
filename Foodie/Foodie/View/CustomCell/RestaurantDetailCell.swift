

import UIKit

class RestaurantDetailCell: UITableViewCell {

    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblItemCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = appLigtGrayColor.cgColor
        addView.layer.borderWidth = 1
        addView.layer.borderColor = appLigtGrayColor.cgColor
//        btnAdd.isHidden = false
//        addView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//    @IBAction func addClicked(_ sender: Any) {
//        btnAdd.isHidden = true
//        addView.isHidden = false
//    }
//
//    @IBAction func plusClicked(_ sender: Any) {
//        var a : Int = Int(lblItemCount.text!)!
//        a = a + 1
//        lblItemCount.text = "\(a)"
//    }
//
//    @IBAction func minusClicked(_ sender: Any) {
//        var a : Int = Int(lblItemCount.text!)!
//        a = a - 1
//        lblItemCount.text = "\(a)"
//    }
}
