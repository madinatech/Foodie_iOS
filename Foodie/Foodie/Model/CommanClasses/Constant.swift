
import Foundation
import UIKit

typealias ItemLoadedBlock = (_ result: Any, _ error : String) -> (Void)

@available(iOS 10.0, *)

let appDelegateShared = UIApplication.shared.delegate as? AppDelegate
let appThemeColor = UIColor.init(red: 226.0/255.0, green: 68.0/255.0, blue: 37.0/255.0, alpha: 1.0)
let appLigtGrayColor = UIColor.init(red: 221.0/255.0, green: 222.0/255.0, blue: 223.0/255.0, alpha: 1.0)
let appBorderColor = UIColor.init(red: 186.0/255.0, green: 186.0/255.0, blue: 186.0/255.0, alpha: 1.0)
let appGreenColor = UIColor.init(red: 43.0/255.0, green: 183.0/255.0, blue: 124.0/255.0, alpha: 1.0)


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
