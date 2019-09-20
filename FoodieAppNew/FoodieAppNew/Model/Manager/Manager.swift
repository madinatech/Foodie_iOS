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
                    let dict = FEMDeserializer.object(fromRepresentation: originalDict, mapping: VerifyUser.defaultMapping(), context: localContext)
                    
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
                    let dict = FEMDeserializer.object(fromRepresentation: originalDict, mapping: VerifyUser.defaultMapping(), context: localContext)
                    
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
    
}
