import Foundation

@objc(Cusines)
open class Cusines: _Cusines {
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Cusines.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Cusines.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        //        mapping.primaryKey = "entity_id"
        return mapping
    }
    
    class func getAll() -> [Cusines] {
        var cusinesArray = [Cusines]()
        var newCusinesArray = [Cusines]()
        var nameArray  = [String]()
        cusinesArray = Cusines.mr_findAllSorted(by: "name", ascending: true) as! [Cusines]
        
        for cusines in cusinesArray{
            if(!nameArray.contains(cusines.name ?? "")){
                nameArray.append(cusines.name ?? "")
            }
        }
        for name in nameArray{
            let cusines = getByName(name: name)
            if(cusines.name != nil){
                newCusinesArray.append(cusines)
            }
        }
        
        return  newCusinesArray//Cusines.mr_findAllSorted(by: "name", ascending: true) as! [Cusines]
    }
    
    class func getByName(name: String) -> Cusines {
        let pre = NSPredicate(format: "name == %@", name)
        if let cusines = Cusines.mr_findFirst(with: pre) {
            return cusines
        }
        return Cusines.mr_createEntity()!
    }
    
}
