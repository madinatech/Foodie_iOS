import Foundation

@objc(Images)
open class Images: _Images {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Images.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Images.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        return mapping
    }
}
