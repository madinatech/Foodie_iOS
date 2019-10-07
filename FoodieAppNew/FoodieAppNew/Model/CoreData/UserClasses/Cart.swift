import Foundation
import MagicalRecord

@objc(Cart)
open class Cart: _Cart {
    
    func saveEntity() {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (contectDidSave, error) in
        }
    }
    
    class func createCartEntity() -> Cart{
        if let cart : Cart = Cart.mr_findFirst() {
            return cart
        }
        return Cart.mr_createEntity()!
    }
    
    class func removeEntity() {
        MagicalRecord.save(blockAndWait: { (localContext:NSManagedObjectContext) in
            Cart.mr_truncateAll(in: localContext)
             LocalCart.mr_truncateAll(in: localContext)
        })
        
    }
    
    func getCartItem(cart: Cart, selectedItem : Items) -> LocalCart{
        var itemsArray = [LocalCart]()
        var item : LocalCart = LocalCart.createCartItemEntity()
        itemsArray = cart.cart_item.allObjects as! [LocalCart]
        for local_item in itemsArray{
            if(local_item.item_id == selectedItem.entity_id){
                item = local_item
                break
            }
        }
        return item
    }
    
}
