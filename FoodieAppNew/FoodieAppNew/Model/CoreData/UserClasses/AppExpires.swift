import Foundation
import FastEasyMapping
import MagicalRecord

@objc(AppExpires)
open class AppExpires: _AppExpires {
    
    class func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: AppExpires.entityName())
        var dict: [String: String] = CDHelper.mapping(cls: AppExpires.self) as! [String : String]
        dict.removeValue(forKey: "expires")
        dict.removeValue(forKey: "warning")
        mapping.addAttributes(from: dict)
        mapping.addAttribute(AppExpires.dateTimeAttribute(for: "expires", andKeyPath: "expires"))
        mapping.addAttribute(AppExpires.dateTimeAttribute(for: "warning", andKeyPath: "warning"))
        
        return mapping
    }
    
}
