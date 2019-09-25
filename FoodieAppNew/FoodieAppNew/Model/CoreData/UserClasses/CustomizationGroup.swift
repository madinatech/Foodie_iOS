import Foundation

@objc(CustomizationGroup)
open class CustomizationGroup: _CustomizationGroup {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: CustomizationGroup.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: CustomizationGroup.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        mapping.addToManyRelationshipMapping(GroupValues.defaultMapping(), forProperty: "group_values", keyPath: "group_values")
        mapping.primaryKey = "entity_id"
        return mapping
    }
}
