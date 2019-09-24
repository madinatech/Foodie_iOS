
import UIKit

class InfoVC: UIViewController , UIGestureRecognizerDelegate{
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblOpening: UILabel!
    var restaurant = Restaurant()
    var openingTimes = [OpeningTimes]()
    
    class func initViewController(restaurant: Restaurant) -> InfoVC {
        let vc = InfoVC.init(nibName: "InfoVC", bundle: nil)
        vc.restaurant = restaurant
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        topView.addGestureRecognizer(tap)
        
         openingTimes = restaurant.opening_times.allObjects as! [OpeningTimes]
        for openTime in openingTimes{
            if(DateUtils.getTodayWeekDay() == openTime.day){
                lblOpening.text = "Opening hours today:  \(DateUtils.getStringFormat(str: openTime.opening_time ?? "")) to \(DateUtils.getStringFormat(str: openTime.closing_time ?? ""))"
            }
        }

      
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
}
