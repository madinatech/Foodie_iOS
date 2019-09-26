import Foundation

@objc(City)
open class City: _City {
    
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: City.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: City.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        mapping.addToManyRelationshipMapping(Area.defaultMapping(), forProperty: "areas", keyPath: "areas")
        mapping.primaryKey = "city_id"
        return mapping
    }
    
    class func getCityByName(name: String) -> City {
        let pre = NSPredicate(format: "city_name == %@", name)
        if let city = City.mr_findFirst(with: pre) {
            return city
        }
        return City.mr_createEntity()!
    }
}
