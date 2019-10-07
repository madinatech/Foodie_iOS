import Foundation
import MagicalRecord

@objc(LocalCart)
open class LocalCart: _LocalCart {
    
    class func getAll() -> [LocalCart] {
        return  LocalCart.mr_findAllSorted(by: "added_date", ascending: true) as! [LocalCart]
    }
    
    func saveEntity() {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (contectDidSave, error) in
            if(contectDidSave){
            }else{
            }
        }
    }
    
    class func createCartItemEntity() -> LocalCart{
        return LocalCart.mr_createEntity()!
    }
    
     func removeEntity() {
        MagicalRecord.save(blockAndWait: { (localContext:NSManagedObjectContext) in
           self.mr_deleteEntity(in: localContext)
        })
        
    }
}
