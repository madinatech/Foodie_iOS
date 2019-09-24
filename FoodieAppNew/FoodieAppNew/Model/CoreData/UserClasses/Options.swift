import Foundation

@objc(Options)
open class Options: _Options {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Options.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Options.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        mapping.primaryKey = "entity_id"
        return mapping
    }
}
