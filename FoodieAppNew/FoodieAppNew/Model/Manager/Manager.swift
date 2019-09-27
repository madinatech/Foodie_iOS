import UIKit
import FastEasyMapping
import MagicalRecord
class Manager: NSObject {
    var itemLoadedBlock : ItemLoadedBlock = {_,_ in }
    
    class func sharedManager() -> Manager {
        var singleton: Manager? = nil
        if singleton == nil {
            singleton = Manager()
        }
        return singleton!
    }
    
    func verifyExistingUser(mobileNumber: String, code : String, block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kVerifyUser)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                let dict : [String: Any] = request.serverData["data"] as! [String : Any]
                let originalDict : [String: Any] = dict["original"] as! [String : Any]
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                    _ = FEMDeserializer.object(fromRepresentation: originalDict, mapping: VerifyUser.defaultMapping(), context: localContext)
                    
                }, completion: { (isSuccess, error) in
                    self.itemLoadedBlock(dict,"")
                })
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        
        request.setParameter(mobileNumber, forKey: "phone")
        request.setParameter(code, forKey: "code")
        request.setParameter("login", forKey: "type")
        request.startRequest()
        
    }
    
    func verifyNewUser(mobileNumber: String, code : String, name : String, email : String, block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kVerifyUser)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                let dict : [String: Any] = request.serverData["data"] as! [String : Any]
                let originalDict : [String: Any] = dict["original"] as! [String : Any]
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                    _ = FEMDeserializer.object(fromRepresentation: originalDict, mapping: VerifyUser.defaultMapping(), context: localContext)
                    
                }, completion: { (isSuccess, error) in
                    self.itemLoadedBlock(dict,"")
                })
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        
        request.setParameter(mobileNumber, forKey: "phone")
        request.setParameter(code, forKey: "code")
        request.setParameter("register", forKey: "type")
        request.setParameter(name, forKey: "name")
        request.setParameter(email, forKey: "email")
        request.setParameter("3", forKey: "origin")
        request.startRequest()
        
    }
    
    func loadRestaurentList(area : Int, block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kGetRestaurantList)", method: RequestMethod(rawValue: "GET")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                let arry : [[String: Any]] = request.serverData["data"] as! [[String: Any]]
                if(arry.count <= 0){
                    self.itemLoadedBlock("","No restaurant found")
                } else {
                    MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                        _ = FEMDeserializer.collection(fromRepresentation: arry, mapping: Restaurant.defaultMapping(), context: localContext)
                        
                    }, completion: { (isSuccess, error) in
                        self.itemLoadedBlock(arry,"")
                    })
                }
                
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        request.setParameter(area, forKey: "area")
        request.startRequest()
    }
    
    func loadFavRestaurentList(block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kGetFavouriteList)", method: RequestMethod(rawValue: "GET")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                let array : [[String: Any]] = request.serverData["favourites"] as! [[String: Any]]
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                    _ = FEMDeserializer.collection(fromRepresentation: array, mapping: Favourite.defaultMapping(), context: localContext)
                    
                }, completion: { (isSuccess, error) in
                    self.itemLoadedBlock(array,"")
                })
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        let account = AccountManager.instance().activeAccount
        request.setParameter(account?.user_id ?? "", forKey: "user_id")
        request.startRequest()
    }
    
    func loadCountry(block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kGetCountry)", method: RequestMethod(rawValue: "GET")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                let dict : [String: Any] = request.serverData["data"] as! [String: Any]
                
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                    _ = FEMDeserializer.object(fromRepresentation: dict, mapping: Country.defaultMapping(), context: localContext)
                    
                }, completion: { (isSuccess, error) in
                    self.itemLoadedBlock(dict,"")
                })
                
                
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        request.startRequest()
    }
    
    func addNewAddress(address: String, addressType: String, city: String, town: String, street: String, landmark : String, isDefault: Int, block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kAddAddress)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                let array : [[String: Any]] = request.serverData["address"] as! [[String: Any]]
                
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                    _ = FEMDeserializer.collection(fromRepresentation: array, mapping: Address.defaultMapping(), context: localContext)
                    
                }, completion: { (isSuccess, error) in
                    self.itemLoadedBlock(array,"")
                })
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        let account = AccountManager.instance().activeAccount
        request.setParameter(account?.user_id ?? "", forKey: "user_id")
        request.setParameter(address, forKey: "address")
        request.setParameter(addressType, forKey: "address_type")
        request.setParameter(city, forKey: "city")
        request.setParameter(town, forKey: "town")
        request.setParameter(street, forKey: "street")
        request.setParameter(landmark, forKey: "landmark")
        request.setParameter(isDefault, forKey: "is_default")
        request.startRequest()
    }
    
    func loadAddress(block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kAddAddress)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                let array : [[String: Any]] = request.serverData["address"] as! [[String: Any]]
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
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
        request.startRequest()
    }
}
