

import UIKit

class SearchHeader: UIView {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var btnViewMenu: UIButton!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "SearchHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
