import Foundation
import MagicalRecord
import FastEasyMapping

@objc(Address)
open class Address: _Address {
    
    var itemLoadedBlock : ItemLoadedBlock = {_,_ in }
    
    class func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: Address.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Address.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        
        mapping.addRelationshipMapping(Area.defaultMapping(), forProperty: "area", keyPath: "area")
        mapping.addRelationshipMapping(City.defaultMapping(), forProperty: "city", keyPath: "city")
        mapping.addRelationshipMapping(Country.defaultMapping(), forProperty: "country", keyPath: "country")
        mapping.primaryKey = "entity_id"
        return mapping
    }
    
    class func getAll() -> [Address] {
        let pre = NSPredicate(format: "entity_id != 0")
        return Address.mr_findAll(with: pre) as! [Address]
    }
    
    
    class func getUserAddress(userID: Int) -> [Address] {
        let pre = NSPredicate(format: "user_id == %d", userID)
        return Address.mr_findAll(with: pre) as! [Address]
    }
    
    class func getUserDefaultAddress(userID: Int) -> Address {
        let pre = NSPredicate(format: "user_id == %d && is_default == 1", userID)
        if let user = Address.mr_findFirst(with: pre) {
            return user
        }
        return Address.mr_createEntity()!
    }
    
    class func getSelectedAddress() -> Address {
        let pre = NSPredicate(format: "is_selected == true")
        if let user = Address.mr_findFirst(with: pre) {
            return user
        }
        return Address.mr_createEntity()!
        
    }
    
    func deleteAddress(block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kDeleteAddress)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                let array : [[String: Any]] = request.serverData["address"] as! [[String: Any]]
                
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                    //                    Address.mr_truncateAll(in: localContext)
                    let dict = FEMDeserializer.collection(fromRepresentation: array, mapping: Address.defaultMapping(), context: localContext)
                    
                }, completion: { (isSuccess, error) in
                    self.itemLoadedBlock(array,"")
                })
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        let account = AccountManager.instance().activeAccount
        request.setParameter(account?.user_id ?? "", forKey: "user_id")
        request.setParameter(self.entity_id, forKey: "id")
        request.startRequest()
    }
}
