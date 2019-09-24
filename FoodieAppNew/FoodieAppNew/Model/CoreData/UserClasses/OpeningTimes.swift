import Foundation

@objc(OpeningTimes)
open class OpeningTimes: _OpeningTimes {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: OpeningTimes.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: OpeningTimes.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        return mapping
    }
}
