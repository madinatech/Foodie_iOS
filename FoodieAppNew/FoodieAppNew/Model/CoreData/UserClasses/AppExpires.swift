import Foundation
import FastEasyMapping
import MagicalRecord

@objc(AppExpires)
open class AppExpires: _AppExpires {
    
    class func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: AppExpires.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: AppExpires.self) as! [String : String]
       
        mapping.addAttributes(from: dict)
      
        
        return mapping
    }
    
}
