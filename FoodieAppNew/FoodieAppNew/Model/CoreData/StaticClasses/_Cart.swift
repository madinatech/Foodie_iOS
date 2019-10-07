// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Cart.swift instead.

import Foundation
import CoreData

public enum CartAttributes: String {
    case cart_Quantity = "cart_Quantity"
    case restaurant_id = "restaurant_id"
    case restaurant_name = "restaurant_name"
    case total_amount = "total_amount"
    case total_items = "total_items"
}

public enum CartRelationships: String {
    case cart_item = "cart_item"
}

open class _Cart: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Cart"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Cart.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var cart_Quantity: Int32 // Optional scalars not supported

    @NSManaged open
    var restaurant_id: Int32 // Optional scalars not supported

    @NSManaged open
    var restaurant_name: String?

    @NSManaged open
    var total_amount: Int32 // Optional scalars not supported

    @NSManaged open
    var total_items: Int32 // Optional scalars not supported

    // MARK: - Relationships

    @NSManaged open
    var cart_item: NSSet

    open func cart_itemSet() -> NSMutableSet {
        return self.cart_item.mutableCopy() as! NSMutableSet
    }

}

extension _Cart {

    open func addCart_item(_ objects: NSSet) {
        let mutable = self.cart_item.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.cart_item = mutable.copy() as! NSSet
    }

    open func removeCart_item(_ objects: NSSet) {
        let mutable = self.cart_item.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.cart_item = mutable.copy() as! NSSet
    }

    open func addCart_itemObject(_ value: LocalCart) {
        let mutable = self.cart_item.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.cart_item = mutable.copy() as! NSSet
    }

    open func removeCart_itemObject(_ value: LocalCart) {
        let mutable = self.cart_item.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.cart_item = mutable.copy() as! NSSet
    }

}

