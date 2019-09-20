import Foundation
import FastEasyMapping
import MagicalRecord

@objc(PaymentOption)
open class PaymentOption: _PaymentOption {
    
    class func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: PaymentOption.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: PaymentOption.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        
        mapping.primaryKey = "entity_id"
        return mapping
    }
}
