import Foundation

@objc(Restaurant)
open class Restaurant: _Restaurant {
    
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Restaurant.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Restaurant.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        
        mapping.addRelationshipMapping(Images.defaultMapping(), forProperty: "images", keyPath: "images")
        mapping.addRelationshipMapping(Location.defaultMapping(), forProperty: "location", keyPath: "location")
         mapping.addRelationshipMapping(Offerings.defaultMapping(), forProperty: "offerings", keyPath: "offerings")
        
        mapping.addToManyRelationshipMapping(Cusines.defaultMapping(), forProperty: "cuisines", keyPath: "cuisines")
         mapping.addToManyRelationshipMapping(Menu.defaultMapping(), forProperty: "menus", keyPath: "menus")
         mapping.addToManyRelationshipMapping(OpeningTimes.defaultMapping(), forProperty: "opening_times", keyPath: "opening_times")
        mapping.primaryKey = "entity_id"
        return mapping
    }
    
    class func getAll() -> [Restaurant] {
        return  Restaurant.mr_findAllSorted(by: "entity_id", ascending: true) as! [Restaurant]
    }
}
