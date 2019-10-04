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
    
    class func getDeliveryUnder() -> [Restaurant] {
        let pre = NSPredicate(format: "delivery_time <= 30")
        let arr : [Restaurant] = Restaurant.mr_findAllSorted(by: "entity_id", ascending: true, with: pre) as! [Restaurant]
        return arr
        
    }
    class func getPickupRestaurants() -> [Restaurant] {
        let pre = NSPredicate(format: "self.offerings.collection == true")
        let arr : [Restaurant] = Restaurant.mr_findAllSorted(by: "entity_id", ascending: true, with: pre) as! [Restaurant]
        return arr
        
    }
    
    class func getDineInRestaurants() -> [Restaurant] {
        let pre = NSPredicate(format: "self.offerings.dine_in == true")
        let arr : [Restaurant] = Restaurant.mr_findAllSorted(by: "entity_id", ascending: true, with: pre) as! [Restaurant]
        return arr
        
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
    
    class func getAllByCusines(cusinesName : [String]) -> [Restaurant] {
        let restAray = getAll()
        var newRest = [Restaurant]()
        for name in cusinesName{
            for rest in restAray{
                let cusinesArray : [Cusines] = rest.cuisines.allObjects as! [Cusines]
                for cusine in cusinesArray{
                    if(name == cusine.name){
                        if(!newRest.contains(rest)){
                            newRest.append(rest)
                        }
                    }
                }
            }
        }
        return newRest
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
    
    class func getAllCloseRestaurant() -> [Restaurant] {
        let restAray = getAll()
        var newRestArray = [Restaurant]()
        for rest in restAray{
            let  openingTimes = rest.opening_times.allObjects as! [OpeningTimes]
            for openTime in openingTimes{
                if(DateUtils.getTodayWeekDay() == openTime.day){
                    let closeTime = openTime.closing_time
                    let currentTime = DateUtils.get24TimeFromDate(date: Date())
                    let close_time : Int = Int(closeTime?.replacingOccurrences(of: ":", with: "") ?? "") ?? 0
                    let current_Time : Int = Int(currentTime.replacingOccurrences(of: ":", with: "") ) ?? 0
                    if(current_Time > close_time){
                        newRestArray.append(rest)
                    }
                    
                }
            }
        }
        
        return newRestArray
    }
    
    class func getAllOpenRestaurant() -> [Restaurant] {
        let restAray = getAll()
        var newRestArray = [Restaurant]()
        for rest in restAray{
            let  openingTimes = rest.opening_times.allObjects as! [OpeningTimes]
            for openTime in openingTimes{
                if(DateUtils.getTodayWeekDay() == openTime.day){
                    let closeTime = openTime.closing_time
                    let currentTime = DateUtils.get24TimeFromDate(date: Date())
                    let close_time : Int = Int(closeTime?.replacingOccurrences(of: ":", with: "") ?? "") ?? 0
                    let current_Time : Int = Int(currentTime.replacingOccurrences(of: ":", with: "") ) ?? 0
                    if(current_Time <= close_time){
                        newRestArray.append(rest)
                    }
                    
                }
            }
        }
        return newRestArray
    }
    
    class func getAllRestaurant() -> [Restaurant] {
        let openRestArray = getAllOpenRestaurant()
        let closeRestArray = getAllCloseRestaurant()
        var newRestArray = openRestArray
        for rest in closeRestArray{
            rest.is_closed = true
            newRestArray.append(rest)
        }
        
        return newRestArray
    }
    
}
