
import UIKit
import Foundation
import Alamofire

//Block
typealias ResponseBlock = (_ success : Bool, _ request: Request, _ errorMessage: NSString) -> (Void)

public enum RequestMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
    case multiPartForm = "MULTI_PART_FORM"
}

class Request: NSObject {
    var methodType : RequestMethod = RequestMethod(rawValue: "GET")!
    var params:[String:Any] = [:]
    var responseBlock: ResponseBlock  = {_,_,_ in }
    var _urlPart = NSString()
    var postParameters: [String:Any] = [:]
    var isSuccess = Bool()
    var serverData = [String :Any]()
    var headers = HTTPHeaders()
    var imageData = Data()
    
    init(url urlString: String, method: RequestMethod, block: @escaping ResponseBlock) {
        super.init()
        _urlPart = urlString as NSString
        methodType = method
        postParameters = [String:Any]()
        responseBlock = block
    }
    
    func setParameter(_ parameter: Any, forKey key: String) {
        postParameters[key] = parameter
    }
    
    func setParameter(dist_flag : String , lati : String , longi : String , owners : [String] ){
        let parameters = [
            "dist_flag": dist_flag,
            "lati": lati,
            "longi": longi,
            "owners": owners
            ] as [String : Any]
        
        postParameters = parameters
    }
    
    func startRequest()  {
       if(_urlPart.contains(kLogin) || _urlPart.contains(kVerifyUser)){
                headers = ["Authorization" : Utils.fetchString(forKey: AuthorizationToken)]
       }
        
        if methodType == RequestMethod.get{
            self .requestGETURL(_urlPart as String, success: { (JSON) in
                self.serverData = JSON.dictionaryObject!
                self.isSuccess = true
                
                if let success = self.serverData["success"] as? Bool {
                    self.isSuccess = true
                    self.requestSuccess(msg: "")
                } else {
                    self.isSuccess = false
                    self.requestSuccess(msg: self.serverData["msg"] as! String)
                }
            }, failure: { (Error) in
                self.isSuccess = false
                self.requestFailedWithError(error: Error as NSError)
            })
        } else  if methodType == RequestMethod.post {
            self .requestPOSTURL(_urlPart as String, success: { (JSON) in
                var dict = [String :Any]()
                dict = JSON.dictionaryObject!
                self.serverData = dict
               
            
                if let success = self.serverData["success"] as? Bool {
                    if success == false{
                        self.isSuccess = false
                        let userInfo: [AnyHashable : Any] = [ NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: self.serverData["msg"] as! String, comment: "") , NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: self.serverData["msg"] as! String, comment: "") ]
                        let err = NSError(domain: "ShiploopHttpResponseErrorDomain", code: 401, userInfo: userInfo as? [String : Any])
                        self.requestFailedWithError(error:err)
                    } else {
                        if let msg = self.serverData["msg"] as? String {
                            self.isSuccess = true
                            self.requestSuccess(msg: msg)
                        } else {
                            self.isSuccess = true
                            self.requestSuccess(msg: "")
                        }
                    }
                } else {
                    if let msg = self.serverData["msg"] as? String {
                        self.isSuccess = true
                        self.requestSuccess(msg: msg)
                    } else {
                        self.isSuccess = true
                        self.requestSuccess(msg: "")
                    }
                }
            }, failure: { (Error) in
                self.isSuccess = false
                self.requestFailedWithError(error: Error as NSError)
            })
        } else  if methodType == RequestMethod.put {
            self .requestPUTURL(_urlPart as String, success: { (JSON) in
                self.serverData = JSON.dictionaryObject!
                
                if let is_error = self.serverData["is_error"] as? Bool {
                    if is_error {
                        self.isSuccess = false
                        let userInfo: [AnyHashable : Any] = [ NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: self.serverData["msg"] as! String, comment: "") , NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: self.serverData["msg"] as! String, comment: "") ]
                        let err = NSError(domain: "ShiploopHttpResponseErrorDomain", code: 401, userInfo: userInfo as? [String : Any])
                        self.requestFailedWithError(error:err)
                    } else {
                        if let msg = self.serverData["msg"] as? String {
                            self.isSuccess = true
                            self.requestSuccess(msg: msg)
                        } else {
                            self.isSuccess = true
                            self.requestSuccess(msg: "")
                        }
                    }
                } else {
                    if let msg = self.serverData["msg"] as? String {
                        self.isSuccess = true
                        self.requestSuccess(msg: msg)
                    } else {
                        self.isSuccess = true
                        self.requestSuccess(msg: "")
                    }
                }
            }, failure: { (Error) in
                self.isSuccess = false
                self.requestFailedWithError(error: Error as NSError)
            })
        }else  if methodType == RequestMethod.delete {
            self .requestDELETEURL(_urlPart as String, success: { (JSON) in
                self.serverData = JSON.dictionaryObject!
                
                if let is_error = self.serverData["is_error"] as? Bool {
                    if is_error {
                        self.isSuccess = false
                        let userInfo: [AnyHashable : Any] = [ NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: self.serverData["msg"] as! String, comment: "") , NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: self.serverData["msg"] as! String, comment: "") ]
                        let err = NSError(domain: "ShiploopHttpResponseErrorDomain", code: 401, userInfo: userInfo as? [String : Any])
                        self.requestFailedWithError(error:err)
                    } else {
                        if let msg = self.serverData["msg"] as? String {
                            self.isSuccess = true
                            self.requestSuccess(msg: msg)
                        } else {
                            self.isSuccess = true
                            self.requestSuccess(msg: "")
                        }
                    }
                } else {
                    if let msg = self.serverData["msg"] as? String {
                        self.isSuccess = true
                        self.requestSuccess(msg: msg)
                    } else {
                        self.isSuccess = true
                        self.requestSuccess(msg: "")
                    }
                }
            }, failure: { (Error) in
                self.isSuccess = false
                self.requestFailedWithError(error: Error as NSError)
            })
        } else if methodType == RequestMethod.multiPartForm {
            self .requestMULTIPARTURL(_urlPart as String, success: { (JSON) in
                var dict = [String :Any]()
                dict = JSON.dictionaryObject!
                self.serverData = dict["response"] as! [String : Any]//JSON.dictionaryObject!
                if let sflag = self.serverData["sflag"] as? String {
                    if sflag == "1"{
//                        appDelegateShared?.logout()
                        return
                    }
                }
                if let is_deactivate = self.serverData["is_deactivate"] as? String {
                    if is_deactivate == "1"{
//                        appDelegateShared?.logout()
                        return
                    }
                }
                if let under_maintenance = self.serverData["under_maintenance"] as? String {
                    if under_maintenance == "1"{
//                        appDelegateShared?.logout()
                        return
                    }
                }
                
                if let status = self.serverData["status"] as? Bool {
                    if status == false{
                        self.isSuccess = false
                        let userInfo: [AnyHashable : Any] = [ NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: self.serverData["msg"] as! String, comment: "") , NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: self.serverData["msg"] as! String, comment: "") ]
                        let err = NSError(domain: "ShiploopHttpResponseErrorDomain", code: 401, userInfo: userInfo as? [String : Any])
                        self.requestFailedWithError(error:err)
                    } else {
                        if let msg = self.serverData["msg"] as? String {
                            self.isSuccess = true
                            self.requestSuccess(msg: msg)
                        } else {
                            self.isSuccess = true
                            self.requestSuccess(msg: "")
                        }
                    }
                } else {
                    if let msg = self.serverData["msg"] as? String {
                        self.isSuccess = true
                        self.requestSuccess(msg: msg)
                    } else {
                        self.isSuccess = true
                        self.requestSuccess(msg: "")
                    }
                }
            }, failure: { (Error) in
                self.isSuccess = false
                self.requestFailedWithError(error: Error as NSError)
            })
        }
        
    }
    
    func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL, method: .get, parameters: postParameters, headers: headers).responseJSON { (responseObject) -> Void in
            if responseObject.response?.statusCode == 401{
                if #available(iOS 10.0, *) {
                    //                    appDelegateShared?.logout()
                } else { }
                return
            }
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    func requestPOSTURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        //        Alamofire.request(strURL, method: .post, parameters: postParameters, headers: headers).responseJSON { (responseObject) -> Void in
        Alamofire.request(strURL, method: .post, parameters: postParameters,encoding: JSONEncoding.default, headers: headers).responseJSON
            { (responseObject) -> Void in
                if responseObject.response?.statusCode == 401{
                    if #available(iOS 10.0, *) {
                        //                    appDelegateShared?.logout()
                    } else {
                    }
                    return
                }
                
                if responseObject.result.isSuccess {
                    let resJson = JSON(responseObject.result.value!)
                    success(resJson)
                }
                
                if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    failure(error)
                }
        }
    }
    func requestMULTIPARTURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        let jsonData = try! JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted)
//        print("json String=%@",stringify(json: postParameters))
        let url = try! URLRequest(url: URL(string:strURL)!, method: .post, headers: headers)
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(jsonData, withName: "data")
                multipartFormData.append(self.imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
        },
                         with: url,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { (responseObject) -> Void in
                                    if responseObject.response?.statusCode == 401{
                                        if #available(iOS 10.0, *) {
                                            //                    appDelegateShared?.logout()
                                        } else {
                                        }
                                        return
                                    }
                                    
                                    if responseObject.result.isSuccess {
                                        
                                        let resJson = JSON(responseObject.result.value!)
                                        success(resJson )
                                    }
                                    
                                    if responseObject.result.isFailure {
                                        let error : Error = responseObject.result.error!
                                        failure(error)
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                                failure(encodingError)
                            }
        })
    }
    
    
    func requestPUTURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        //        Alamofire.request(strURL, method: .put, parameters: postParameters, headers: headers).responseJSON { (responseObject) -> Void in
        Alamofire.request(strURL, method: .put, parameters: postParameters,encoding: JSONEncoding.default, headers: headers).responseJSON
            { (responseObject) -> Void in
                if responseObject.response?.statusCode == 401{
                    if #available(iOS 10.0, *) {
                        //                    appDelegateShared?.logout()
                    } else {
                    }
                    return
                }
                
                if responseObject.result.isSuccess {
                    let resJson = JSON(responseObject.result.value!)
                    success(resJson)
                }
                
                if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    failure(error)
                }
        }
    }
    
    func requestDELETEURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL, method: .delete, parameters: postParameters , headers: headers ).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    func requestSuccess(msg:String)  {
        responseBlock(true,self,msg as NSString)
    }
    
    func requestFailedWithError (error: NSError){
        responseBlock(false, self,error.localizedDescription as NSString)
    }
}
