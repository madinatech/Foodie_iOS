import Foundation

@objc(Restaurant)
open class Restaurant: _Restaurant {
      var itemLoadedBlock : ItemLoadedBlock = {_,_ in }
    
    class func defaultMapping() -> FEMMapping {
        
        let mapping = FEMMapping(entityName: Restaurant.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Restaurant.self) as! [String : String]
        
        mapping.addAttributes(from: dict)
        
        mapping.addRelationshipMapping(Images.defaultMapping(), forProperty: "images", keyPath: "images")
        mapping.addRelationshipMapping(Location.defaultMapping(), forProperty: "location", keyPath: "location")
         mapping.addRelationshipMapping(Offerings.defaultMapping(), forProperty: "offerings", keyPath: "offerings")
        
        mapping.addToManyRelationshipMapping(Cusines.defaultMapping(), forProperty: "cuisines", keyPath: "cuisines")
         mapping.addToManyRelationshipMapping(Menu.defaultMapping(), forProperty: "menus", keyPath: "menus")
         mapping.addToManyRelationshipMapping(OpeningTimes.defaultMapping(), forProperty: "opening_times", keyPath: "opening_times")
        mapping.primaryKey = "entity_id"
        return mapping
    }
    
    class func getAll() -> [Restaurant] {
        return  Restaurant.mr_findAllSorted(by: "entity_id", ascending: true) as! [Restaurant]
    }
    
    func addFavouriteResTaurant(block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kAddFavourite)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                self.itemLoadedBlock("","")
                
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        let account = AccountManager.instance().activeAccount
        request.setParameter(account?.user_id ?? "", forKey: "user_id")
        request.setParameter(self.entity_id, forKey: "restaurant_id")
        request.startRequest()
    }
    
    class func getAllByName(name : String) -> [Restaurant] {
        let restAray = getAll()
        var newRest = [Restaurant]()
        for rest in restAray{
            let menuArray : [Menu] = rest.menus.allObjects as! [Menu]
            for menu in menuArray{
                let itemArray : [Items] = menu.items.allObjects as! [Items]
                for item in itemArray{
                    let nameArry = name.split(separator: " ")
                        for name in nameArry{
                            if((rest.name?.containsIgnoringCase(String(name)))!){
                                if(!newRest.contains(rest)){
                                    newRest.append(rest)
                                }
                            }
                            if((item.name?.containsIgnoringCase(String(name)))!){
                                if(!newRest.contains(rest)){
                                    newRest.append(rest)
                                }
                            }
                        }
                }
            }
        }
        return newRest
        //        let pre = NSPredicate(format: "self.menus.items CONTAINS[cd] %@", name)
        //        let arr : [Restaurant] = Restaurant.mr_findAllSorted(by: "name", ascending: true, with: pre) as! [Restaurant]
        //        return arr
    }
    
    class func getAllByItems(name : String) -> [Restaurant] {
        let restAray = getAll()
        var newRest = [Restaurant]()
        for rest in restAray{
            let menuArray : [Menu] = rest.menus.allObjects as! [Menu]
            for menu in menuArray{
                let itemArray : [Items] = menu.items.allObjects as! [Items]
                for item in itemArray{
                    let nameArry = name.split(separator: " ")
                    for name in nameArry{
                        if(item.name?.containsIgnoringCase(String(name)) ?? false){
                            if(!newRest.contains(rest)){
                                newRest.append(rest)
                            }
                        }
                    }
                }
            }
        }
        return newRest
    }
   
}
