
import UIKit
import Foundation
import Photos

let ALERT_TITLE: String = ""

class Utils: NSObject {
    
    
    
    class func convertStringToDouble (str: String) -> Double {
        let value : Double = Double(str) as! Double
        return value
    }
    
    class func getTopViewController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        
        return topController!
    }
    class func getCurrencyFormat(value: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        
        let str = "\(String(numberFormatter.string(from: NSNumber(value:value))!))"
        return str
    }
    
    class func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: ALERT_TITLE, message: message , preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(actionOk)
        
        Utils.getTopViewController().present(alertController, animated: true)
    }
    
    class func isLeapYear(_ year: Int) -> Bool {
        let isLeapYear = ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))
        return isLeapYear
    }
    class func randomNumber(MIN: Int, MAX: Int)-> Int{
        return Int(arc4random_uniform(UInt32(MAX)) + UInt32(MIN));
    }
    
    class func showAlert(withTitle:String, withMessage: String, withButtonTitle:String) {
        let alertController = UIAlertController(title: withTitle, message: withMessage , preferredStyle: .alert)
        let actionOk = UIAlertAction(title: withButtonTitle, style: .default, handler: nil)
        alertController.addAction(actionOk)
        
        Utils.getTopViewController().present(alertController, animated: true)
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func isEmail(txt: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", options: .caseInsensitive)
        return regex?.firstMatch(in: txt, options: [], range: NSMakeRange(0, txt.count)) != nil
    }
    
    class func isNumber(number:String) -> Bool{
        let numberRegEx = "[0-9]{10,13}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        if numberTest.evaluate(with: number) == true {
            return true
        }
        else {
            return false
        }
    }
    
    class func isPhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "[0-9]{6,15}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    class func isZipcode(number:String) -> Bool{
        let numberRegEx = "[0-9]{1,10}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        if numberTest.evaluate(with: number) == true {
            
            return true
        }
        else {
            return false
        }
    }
    
    class func isSimulator() -> Bool {
        return Platform.isSimulator
    }
    
    class func setBottomBorderForTextField(txtField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: txtField.frame.size.height - width, width:  txtField.frame.size.width, height: txtField.frame.size.height)
        
        border.borderWidth = width
        txtField.layer.addSublayer(border)
        txtField.layer.masksToBounds = true
    }
    
    class func setShadowForTextField(textField: UITextField) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = textField.bounds
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path: CGMutablePath = CGMutablePath()
        path.addRect(textField.bounds.insetBy(dx: -42, dy: -42), transform: .identity)
        let someInnerPath = (UIBezierPath(roundedRect: textField.bounds, cornerRadius: textField.layer.cornerRadius).cgPath)
        path.addPath(someInnerPath, transform: .identity)
        path.closeSubpath()
        shadowLayer.path = path
        textField.layer.addSublayer(shadowLayer)
        let maskLayer = CAShapeLayer()
        maskLayer.path = someInnerPath
        shadowLayer.mask = maskLayer
    }
    
    class func setShadowForTextView(textView: UITextView) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = textView.bounds
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path: CGMutablePath = CGMutablePath()
        path.addRect(textView.bounds.insetBy(dx: -15, dy: -15), transform: .identity)
        let someInnerPath = (UIBezierPath(roundedRect: textView.bounds, cornerRadius: textView.layer.cornerRadius).cgPath)
        path.addPath(someInnerPath, transform: .identity)
        path.closeSubpath()
        shadowLayer.path = path
        textView.layer.addSublayer(shadowLayer)
    }
    
    class func setShadowForView(inView: UIView) {
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = inView.bounds
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowOffset = CGSize(width: 1, height:1)
        shadowLayer.shadowOpacity = 0.7
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path: CGMutablePath = CGMutablePath()
        path.addRect(inView.bounds.insetBy(dx: -42, dy: -42), transform: .identity)
        let someInnerPath = (UIBezierPath(roundedRect: inView.bounds, cornerRadius: inView.layer.cornerRadius).cgPath)
        path.addPath(someInnerPath, transform: .identity)
        path.closeSubpath()
        shadowLayer.path = path
        inView.layer.addSublayer(shadowLayer)
        let maskLayer = CAShapeLayer()
        maskLayer.path = someInnerPath
        shadowLayer.mask = maskLayer
    }
    
    class func bottomInnerShadow(imageViewShadow: UIImageView) {
        let gradient = CAGradientLayer()
        gradient.frame = imageViewShadow.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint.init(x: 1, y: 1)
        gradient.endPoint = CGPoint.init(x: 1, y: 0.7)
        if gradient.superlayer == nil {
            imageViewShadow.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    
    class func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        //let scale = newWidth / image.size.width
        //let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newWidth))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newWidth))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    class func load_image(image_url_string:String, view:UIImageView) {
        let URL_IMAGE = URL(string: image_url_string )//"http://www.simplifiedtechy.net/wp-content/uploads/2017/07/simplified-techy-default.png"
        let session = URLSession(configuration: .default)
        
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    
                    //checking if the response contains an image
                    if let imageData = data {
                        
                        //getting the image
                        let image = UIImage(data: imageData)
                        
                        //displaying the image
                        view.image = image
                        
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        getImageFromUrl.resume()
    }
    class func whitespaceString(font: UIFont = UIFont.systemFont(ofSize: 15), width: CGFloat) -> String {
        let kPadding: CGFloat = 20
        let mutable = NSMutableString(string: "")
        let attribute = [NSAttributedString.Key.font: font]
        while mutable.size(withAttributes: attribute).width < width - (2 * kPadding) {
            mutable.append(" ")
        }
        return mutable as String
    }
    
    class func setBottomBorderForView(inView: UIView) {
        inView.layer.borderColor = UIColor.black.cgColor
        inView.layer.borderWidth = 1.0;
    }
    
    class func setBoolForKey(_ value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func fetchBool(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func setStringForKey(_ value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func fetchString(forKey key: String) -> String {
        return UserDefaults.standard.string(forKey: key)!
    }
    
    class func applyGradientForUIView(inView:UIView) {
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: 376, height: 618))
        layer.alpha = 0.7
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        gradient.colors = [ UIColor(red:65/255, green:67/255, blue:63/255, alpha:1).cgColor, UIColor(red:126/255, green:134/255, blue:100/255, alpha:0.65).cgColor]
        //        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.layer.addSublayer(gradient)
        inView.layer.addSublayer(gradient)
    }
    
    class func sendSMTPMail(strUrl: String, request: String, response: String){
        let appVersion : String = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String)!
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "mail.madinagroup.co.tz"
        smtpSession.username = "notificationalert@madinagroup.co.tz"
        smtpSession.password = "Business111*"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslLogin
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "NotificationAlert", mailbox: "ayyaz@madinagroup.co.tz") ?? ""]
        builder.header.from = MCOAddress(displayName: "NotificationAlert", mailbox: "notificationalert@madinagroup.co.tz")
        builder.header.subject = "Crash/Bug report - Foodie"
        
        if(AccountManager.instance().activeAccount != nil){
            let account = AccountManager.instance().activeAccount
            builder.textBody = "Hello,\n\nThere is a new crash report from: \(account?.user_Name ?? "") - \(account?.mobileNumber ?? "").\nOrigin: iOS \nAPI Call: \(strUrl) \nRequest: \(request) \nResponse: \(response)\nApp version: 1"
        } else {
            builder.textBody = "Hello,\n\nThere is a new crash report from Guest user.\nOrigin: iOS \nAPI Call: \(strUrl) \nRequest: \(request) \nResponse: \(response)\nApp version: 1"
        }
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
    class func grayScaleEffect(originalImage : UIImageView)  {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        currentFilter!.setValue(CIImage(image: originalImage.image!), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        originalImage.image = processedImage
//        return originalImage
    }
    
    class func takeScreenShot() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            Utils.screenShotMethod()
            break
        //handle authorized status
        case .denied, .restricted :
            Utils.openPermission()
            break
        //handle denied status
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization() { status in
                switch status {
                case .authorized:
                    Utils.screenShotMethod()
                // as above
                case .denied, .restricted:
                    Utils.openPermission()
                    break
                // as above
                case .notDetermined:
                    Utils.openPermission()
                    break
                    // won't happen but still
                }
            }
        }
    }
    class func screenShotMethod() {
        DispatchQueue.main.async(){
            
            let layer = UIApplication.shared.keyWindow!.layer
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
            layer.render(in: UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(screenshot!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Your snapshot has been cancel to saved to your photos", message: error.localizedDescription, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction) in
                
                //                appDelegateShared?.userDidLogin()
            }
            ac.addAction(OKAction)
            appDelegateShared?.window?.rootViewController?.present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your snapshot has been saved to your photos.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction) in
                
                //               appDelegateShared?.userDidLogin()
            }
            ac.addAction(OKAction)
            appDelegateShared?.window?.rootViewController?.present(ac, animated: true)
        }
    }
    class func openPermission() {
        let alertController = UIAlertController(title:"Photos service is disabled. Use the \("OK") button below to open the settings dialog, where Photo service can be enabled.", message:"", preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    // Checking for setting is opened or not
                    print("Setting is opened: \(success)")
                })
            }
        })
        
        Utils.getTopViewController().present(alertController, animated: true, completion: nil)
    }
}

extension String {
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

extension UIDevice {
    static var isIphoneX: Bool {
        var modelIdentifier = ""
        if isSimulator {
            modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
        } else {
            var size = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: size)
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            modelIdentifier = String(cString: machine)
        }
        
        return modelIdentifier == "iPhone10,3" || modelIdentifier == "iPhone10,6"
    }
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
extension UIColor {
    convenience init(hex: UInt32) {
        let mask = 0x000000FF
        
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}

extension UIView {
    
    func dropShadow() {
        self.layer.shadowColor = UIColor(white: 0.0, alpha: 0.2).cgColor
        self.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.40
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
    }
    func image() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

//extension UIView {
//
//    func addTopBorder(_ color: UIColor, height: CGFloat) {
//        let border = UIView()
//        border.backgroundColor = color
//        border.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(border)
//        border.addConstraint(NSLayoutConstraint(item: border,
//                                                attribute: NSLayoutAttribute.height,
//                                                relatedBy: NSLayoutRelation.equal,
//                                                toItem: nil,
//                                                attribute: NSLayoutAttribute.height,
//                                                multiplier: 1, constant: height))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.top,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.top,
//                                              multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.leading,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.leading,
//                                              multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.trailing,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.trailing,
//                                              multiplier: 1, constant: 0))
//    }
//
//    func addBottomBorder(_ color: UIColor, height: CGFloat) {
//        let border = UIView()
//        border.backgroundColor = color
//        border.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(border)
//        border.addConstraint(NSLayoutConstraint(item: border,
//                                                attribute: NSLayoutAttribute.height,
//                                                relatedBy: NSLayoutRelation.equal,
//                                                toItem: nil,
//                                                attribute: NSLayoutAttribute.height,
//                                                multiplier: 1, constant: height))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.bottom,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.bottom,
//                                              multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.leading,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.leading,
//                                              multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.trailing,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.trailing,
//                                              multiplier: 1, constant: 0))
//    }
//
//    func addLeftBorder(_ color: UIColor, width: CGFloat) {
//        let border = UIView()
//        border.backgroundColor = color
//        border.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(border)
//        border.addConstraint(NSLayoutConstraint(item: border,
//                                                attribute: NSLayoutAttribute.width,
//                                                relatedBy: NSLayoutRelation.equal,
//                                                toItem: nil,
//                                                attribute: NSLayoutAttribute.width,
//                                                multiplier: 1, constant: width))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.leading,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.leading,
//                                              multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.bottom,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.bottom,
//                                              multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.top,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.top,
//                                              multiplier: 1, constant: 0))
//    }
//
//    func addRightBorder(_ color: UIColor, width: CGFloat) {
//        let border = UIView()
//        border.backgroundColor = color
//        border.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(border)
//        border.addConstraint(NSLayoutConstraint(item: border,
//                                                attribute: NSLayoutAttribute.width,
//                                                relatedBy: NSLayoutRelation.equal,
//                                                toItem: nil,
//                                                attribute: NSLayoutAttribute.width,
//                                                multiplier: 1, constant: width))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.trailing,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.trailing,
//                                              multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.bottom,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.bottom,
//                                              multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: border,
//                                              attribute: NSLayoutAttribute.top,
//                                              relatedBy: NSLayoutRelation.equal,
//                                              toItem: self,
//                                              attribute: NSLayoutAttribute.top,
//                                              multiplier: 1, constant: 0))
//    }
//}
