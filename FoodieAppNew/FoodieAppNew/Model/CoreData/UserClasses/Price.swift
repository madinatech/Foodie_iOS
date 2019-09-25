import Foundation

@objc(Price)
open class Price: _Price {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Price.entityName())
        var dict: [String: String] = CDHelper.mapping(cls: Price.self) as! [String : String]
        dict.removeValue(forKey: "valid_from")
        dict.removeValue(forKey: "valid_to")
        mapping.addAttributes(from: dict)
        mapping.addAttribute(Price.dateTimeAttribute(for: "valid_from", andKeyPath: "valid_from"))
        mapping.addAttribute(Price.dateTimeAttribute(for: "valid_to", andKeyPath: "valid_to"))
        return mapping
    }
}
