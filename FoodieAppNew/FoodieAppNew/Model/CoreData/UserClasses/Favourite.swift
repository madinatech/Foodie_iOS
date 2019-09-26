import Foundation

@objc(Favourite)
open class Favourite: _Favourite {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Favourite.entityName())
        var dict: [String: String] = CDHelper.mapping(cls: Favourite.self) as! [String : String]
        dict.removeValue(forKey: "created_at")
       
        
        mapping.addAttributes(from: dict)
        
        mapping.addAttribute(Address.dateTimeAttribute(for: "created_at", andKeyPath: "created_at"))
        mapping.addToManyRelationshipMapping(Restaurant.defaultMapping(), forProperty: "restaurant", keyPath: "restaurant")
        mapping.primaryKey = "favourite_id"
        return mapping
    }
    
    class func getAll() -> [Favourite] {
       
        return Favourite.mr_findAllSorted(by: "created_at", ascending: true) as! [Favourite]
    }
    
}
