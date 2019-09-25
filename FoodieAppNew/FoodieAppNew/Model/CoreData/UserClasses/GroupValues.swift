import Foundation

@objc(GroupValues)
open class GroupValues: _GroupValues {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: GroupValues.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: GroupValues.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        return mapping
    }
}
