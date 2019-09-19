

import UIKit

class SortingCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData (index : Int)  {
        if(index == 0){
            lblTitle.text = "Price: Affordable"
            imgView.image = UIImage.init(named: "Dollar_gray")
        } else if(index == 1) {
            lblTitle.text = "Price: High end"
            imgView.image = UIImage.init(named: "diamond_gray")
        } else if(index == 2){
            lblTitle.text = "Rating"
            imgView.image = UIImage.init(named: "star_gray")
        } else {
            lblTitle.text = "Delivery Time"
            imgView.image = UIImage.init(named: "time_gray")
        }
    }
    
    
    func setSelecteddData(selectdIndex : Int, selectedSection : Int, indePath : IndexPath)  {
        lblTitle.textColor = .lightGray
        view.backgroundColor = appLigtGrayColor
//        imgView.image = UIImage.init(named: "star_gray")
        if(selectedSection == indePath.section && selectdIndex == indePath.row && selectdIndex == 0){
            imgView.image = UIImage.init(named: "Dollar_red")
            lblTitle.textColor = appThemeColor
            view.backgroundColor = appLightThemeColor
        }
        if(selectedSection == indePath.section && selectdIndex == indePath.row && selectdIndex == 1){
            imgView.image = UIImage.init(named: "diamond_red")
            lblTitle.textColor = appThemeColor
            view.backgroundColor = appLightThemeColor
        }
        if(selectedSection == indePath.section && selectdIndex == indePath.row  && selectdIndex == 2){
            imgView.image = UIImage.init(named: "star_red")
            lblTitle.textColor = appThemeColor
            view.backgroundColor = appLightThemeColor
        }
        if(selectedSection == indePath.section && selectdIndex == indePath.row && selectdIndex == 3){
            imgView.image = UIImage.init(named: "time_red")
            lblTitle.textColor = appThemeColor
            view.backgroundColor = appLightThemeColor
        }
        
    }
    
}
