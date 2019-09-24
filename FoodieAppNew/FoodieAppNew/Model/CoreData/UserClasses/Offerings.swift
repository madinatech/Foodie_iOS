import Foundation

@objc(Offerings)
open class Offerings: _Offerings {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Offerings.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Offerings.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        return mapping
    }
}
