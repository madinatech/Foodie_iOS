import Foundation
import FastEasyMapping
import MagicalRecord

@objc(DeliveryOption)
open class DeliveryOption: _DeliveryOption {
    
    class func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: DeliveryOption.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: DeliveryOption.self) as! [String : String]
       
        mapping.addAttributes(from: dict)
      
        mapping.primaryKey = "entity_id"
        return mapping
    }
}
