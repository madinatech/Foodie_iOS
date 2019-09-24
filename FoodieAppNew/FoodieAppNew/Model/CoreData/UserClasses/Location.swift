import Foundation

@objc(Location)
open class Location: _Location {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Location.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Location.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        return mapping
    }
}
