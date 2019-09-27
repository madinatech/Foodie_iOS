import Foundation
import FastEasyMapping
import MagicalRecord

@objc(UserData)
open class UserData: _UserData {
    class func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: UserData.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: UserData.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        
        mapping.addToManyRelationshipMapping(PaymentOption.defaultMapping(), forProperty: "payment_options", keyPath: "payment_options")
           mapping.addToManyRelationshipMapping(DeliveryOption.defaultMapping(), forProperty: "delivery_options", keyPath: "delivery_options")
        mapping.addToManyRelationshipMapping(Address.defaultMapping(), forProperty: "address", keyPath: "address")
        
        return mapping
    }
    
    
}
