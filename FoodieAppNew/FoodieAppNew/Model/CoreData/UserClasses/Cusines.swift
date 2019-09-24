import Foundation

@objc(Cusines)
open class Cusines: _Cusines {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Cusines.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Cusines.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        mapping.primaryKey = "entity_id"
        return mapping
    }
}
