

import UIKit

class AccountHeader: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnHeader: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblLine: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "AccountHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setData (section: Int, isHeaderSelected : Bool)  {
        if(section == 0){
           lblTitle.text = "My Account"
            lblDesc.text = "Addresses, Payments, Favourites, Refferals & Offers"
            lblLine.isHidden = false
              btnHeader.setImage(UIImage.init(named: "downArrow"), for: .normal)
            if(isHeaderSelected == true){
                  btnHeader.setImage(UIImage.init(named: "upArrow"), for: .normal)
            }
        } else {
            lblTitle.text = "Help"
            lblDesc.text = "FAQs & Links"
            lblLine.isHidden = true
            btnHeader.setImage(UIImage.init(named: "rightArrow"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
         super.awakeFromNib()
    }
}
