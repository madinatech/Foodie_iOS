import Foundation

@objc(Items)
open class Items: _Items {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Items.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Items.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
         mapping.addToManyRelationshipMapping(Options.defaultMapping(), forProperty: "options", keyPath: "options")
        mapping.primaryKey = "entity_id"
        return mapping
    }
}
