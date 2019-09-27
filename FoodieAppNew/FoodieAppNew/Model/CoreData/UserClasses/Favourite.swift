import Foundation
import MagicalRecord

@objc(Favourite)
open class Favourite: _Favourite {
     var itemLoadedBlock : ItemLoadedBlock = {_,_ in }
    
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
    
    func removeFavouriteResTaurant(block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kRemoveFavourite)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                let array : [[String: Any]] = request.serverData["favourites"] as! [[String: Any]]
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                    let dict = FEMDeserializer.collection(fromRepresentation: array, mapping: Favourite.defaultMapping(), context: localContext)
                    
                }, completion: { (isSuccess, error) in
                    self.itemLoadedBlock(array,"")
                })
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        let account = AccountManager.instance().activeAccount
        request.setParameter(account?.user_id ?? "", forKey: "user_id")
        request.setParameter(self.favourite_id, forKey: "id")
        request.startRequest()
    }
}
