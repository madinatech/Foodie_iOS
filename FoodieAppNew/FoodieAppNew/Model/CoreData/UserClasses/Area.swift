import Foundation

@objc(Area)
open class Area: _Area {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Area.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Area.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
      
        mapping.primaryKey = "entity_id"
        return mapping
    }
    
    class func getAreaByName(name: String) -> Area {
        let pre = NSPredicate(format: "name == %@", name)
        if let area = Area.mr_findFirst(with: pre) {
            return area
        }
        return Area.mr_createEntity()!
    }
}
