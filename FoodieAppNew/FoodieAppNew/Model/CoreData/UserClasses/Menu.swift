import Foundation

@objc(Menu)
open class Menu: _Menu {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Menu.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Menu.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
           mapping.addToManyRelationshipMapping(Items.defaultMapping(), forProperty: "items", keyPath: "items")
        mapping.primaryKey = "entity_id"
        return mapping
    }
}
