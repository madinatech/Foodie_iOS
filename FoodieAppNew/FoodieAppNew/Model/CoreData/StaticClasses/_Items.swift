// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Items.swift instead.

import Foundation
import CoreData

public enum ItemsAttributes: String {
    case desc = "desc"
    case entity_id = "entity_id"
    case index = "index"
    case item_type = "item_type"
    case item_type_code = "item_type_code"
    case max_quantity = "max_quantity"
    case name = "name"
    case section = "section"
}

public enum ItemsRelationships: String {
    case customization_groups = "customization_groups"
    case price = "price"
}

open class _Items: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Items"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Items.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var desc: String?

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var index: Int32 // Optional scalars not supported

    @NSManaged open
    var item_type: String?

    @NSManaged open
    var item_type_code: String?

    @NSManaged open
    var max_quantity: Int32 // Optional scalars not supported

    @NSManaged open
    var name: String?

    @NSManaged open
    var section: Int32 // Optional scalars not supported

    // MARK: - Relationships

    @NSManaged open
    var customization_groups: NSSet

    open func customization_groupsSet() -> NSMutableSet {
        return self.customization_groups.mutableCopy() as! NSMutableSet
    }

    @NSManaged open
    var price: NSSet

    open func priceSet() -> NSMutableSet {
        return self.price.mutableCopy() as! NSMutableSet
    }

}

extension _Items {

    open func addCustomization_groups(_ objects: NSSet) {
        let mutable = self.customization_groups.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.customization_groups = mutable.copy() as! NSSet
    }

    open func removeCustomization_groups(_ objects: NSSet) {
        let mutable = self.customization_groups.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.customization_groups = mutable.copy() as! NSSet
    }

    open func addCustomization_groupsObject(_ value: CustomizationGroup) {
        let mutable = self.customization_groups.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.customization_groups = mutable.copy() as! NSSet
    }

    open func removeCustomization_groupsObject(_ value: CustomizationGroup) {
        let mutable = self.customization_groups.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.customization_groups = mutable.copy() as! NSSet
    }

}

extension _Items {

    open func addPrice(_ objects: NSSet) {
        let mutable = self.price.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.price = mutable.copy() as! NSSet
    }

    open func removePrice(_ objects: NSSet) {
        let mutable = self.price.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.price = mutable.copy() as! NSSet
    }

    open func addPriceObject(_ value: Price) {
        let mutable = self.price.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.price = mutable.copy() as! NSSet
    }

    open func removePriceObject(_ value: Price) {
        let mutable = self.price.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.price = mutable.copy() as! NSSet
    }

}

