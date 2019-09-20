
import UIKit

typealias AccountBlock = (_ success : Bool, _ request: Account, _ errorMessage: String) -> (Void)
class Account: NSObject ,NSCoding {
    var accountBlock: AccountBlock  = {_,_,_ in }
    
    var token_type : String = ""
    var access_token : String = ""
    var mobileNumber : String = ""
    var existing : String = ""
    let ENCODING_VERSION:Int = 1
    
    override init() {}
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ENCODING_VERSION, forKey: "version")
        
        aCoder.encode(token_type, forKey: "token_type")
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(mobileNumber, forKey: "mobileNumber")
        aCoder.encode(existing, forKey: "existing")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if(aDecoder.decodeInteger(forKey: "version") == ENCODING_VERSION) {
            token_type = aDecoder.decodeObject(forKey: "token_type") as! String
            access_token = aDecoder.decodeObject(forKey: "access_token") as! String
            mobileNumber = aDecoder.decodeObject(forKey: "mobileNumber") as! String
            existing = aDecoder.decodeObject(forKey: "existing") as! String
        }
    }
    
    func parseUserDict(userDict:NSDictionary) {
        if let str = userDict.value(forKey: "token_type") as? String{
            self.token_type = str
        }
        if let str = userDict.value(forKey: "access_token") as? String{
            self.access_token = str
        }
        if let str = userDict.value(forKey: "number") as? String{
            self.mobileNumber = str
        }
        
        if let str = userDict.value(forKey: "existing") as? Bool{
            if(str == true){
                self.existing = "true"
            }else{
                self.existing = "false"
            }
        }
        
        
        
        
    }
    
    func getClientToken(block: @escaping AccountBlock)  {
        accountBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kGetClientToken)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, message:NSString) -> (Void) in
            if(request.isSuccess){
                let serverDict = request.serverData as NSDictionary
                self.parseUserDict(userDict: serverDict)
                Utils.setStringForKey("\(serverDict["token_type"] ?? "") \(serverDict["access_token"] ?? "")", key: AuthorizationToken)
                self.accountBlock(true,self,"")
            } else {
                self.accountBlock(false,self,message as String)
            }
        }
        
        request.setParameter("3", forKey: "client_id")
        request.setParameter("4DQibYoJrb7lwZlhSNUPDofNFAwumk9QxfWFOXIG", forKey: "client_secret")
        request.startRequest()
    }
    
    func loginApicall(block: @escaping AccountBlock)  {
        accountBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kLogin)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, message:NSString) -> (Void) in
            if(request.isSuccess){
                let serverDict = request.serverData as NSDictionary
                self.parseUserDict(userDict: serverDict)
                self.accountBlock(true,self,"")
            } else {
                self.accountBlock(false,self,message as String)
            }
        }
        
        request.setParameter(mobileNumber, forKey: "phone")
        request.startRequest()
    }
    
    
}
