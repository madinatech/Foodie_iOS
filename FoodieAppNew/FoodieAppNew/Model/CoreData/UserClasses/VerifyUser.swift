import Foundation

@objc(VerifyUser)
open class VerifyUser: _VerifyUser {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: VerifyUser.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: VerifyUser.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        
         mapping.addRelationshipMapping(AppExpires.defaultMapping(), forProperty: "app_expires", keyPath: "app_expires")
          mapping.addRelationshipMapping(UserData.defaultMapping(), forProperty: "userData", keyPath: "userData")
        mapping.primaryKey = "entity_id"
        return mapping
    }
}
