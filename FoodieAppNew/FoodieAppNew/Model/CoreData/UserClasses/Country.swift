import Foundation

@objc(Country)
open class Country: _Country {
    
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Country.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Country.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        mapping.addToManyRelationshipMapping(City.defaultMapping(), forProperty: "cities", keyPath: "cities")
        mapping.primaryKey = "country_id"
        return mapping
}
    class func getCountryByName(name: String) -> Country {
        let pre = NSPredicate(format: "country_name == %@", name)
        if let country = Country.mr_findFirst(with: pre) {
            return country
        }
        return Country.mr_createEntity()!
    }
}
