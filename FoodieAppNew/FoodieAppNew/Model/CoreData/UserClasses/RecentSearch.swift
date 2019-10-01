import Foundation
import MagicalRecord

@objc(RecentSearch)
open class RecentSearch: _RecentSearch {
    
    class func getAll() -> [RecentSearch] {
        return  RecentSearch.mr_findAllSorted(by: "added_date", ascending: true) as! [RecentSearch]
    }
    
    func saveEntity() {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (contectDidSave, error) in
            if(contectDidSave){
            }else{
            }
        }
    }
    
    class func createRecentEntity() -> RecentSearch{
        return RecentSearch.mr_createEntity()!
    }
    
    class func removeEntity() {
        MagicalRecord.save(blockAndWait: { (localContext:NSManagedObjectContext) in
            RecentSearch.mr_truncateAll(in: localContext)
        })
        
    }
}
