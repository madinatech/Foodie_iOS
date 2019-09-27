
import Foundation
import UIKit

typealias ItemLoadedBlock = (_ result: Any, _ error : String) -> (Void)

@available(iOS 10.0, *)
let GoogleApiKey = "AIzaSyCx3P5XvbQj7jCtDiGKicIpO4ghjK-68fA"//"AIzaSyBqNHZg05Thqmmoz7OOe3WH71OrhnMJfRA"
let appDelegateShared = UIApplication.shared.delegate as? AppDelegate
let appThemeColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: 1.0)
let appLightThemeColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: 0.2)
let appPurpleColor = UIColor.init(red: 81.0/255.0, green: 62.0/255.0, blue: 157.0/255.0, alpha: 1.0)
let appYellowColor = UIColor.init(red: 250.0/255.0, green: 205.0/255.0, blue: 92.0/255.0, alpha: 1.0)
let appBlackColor = UIColor.init(red: 45.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, alpha: 1.0)
let appLigtGrayColor = UIColor.init(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
let appBorderColor = UIColor.init(red: 186.0/255.0, green: 186.0/255.0, blue: 186.0/255.0, alpha: 1.0)
let appGreenColor = UIColor.init(red: 43.0/255.0, green: 183.0/255.0, blue: 124.0/255.0, alpha: 1.0)


let AuthorizationToken = "AuthorizationToken"
let Selected_Area = "SelectedArea"
let SelectedArea_id = "SelectedAreaId"

@IBDesignable public class RoundButtonHome: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
         layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        // layer.cornerRadius = 25.0
        // clipsToBounds = true
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0.10
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
