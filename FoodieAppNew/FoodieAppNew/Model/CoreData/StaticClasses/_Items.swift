// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Items.swift instead.

import Foundation
import CoreData

public enum ItemsAttributes: String {
    case desc = "desc"
    case entity_id = "entity_id"
    case item_type = "item_type"
    case item_type_code = "item_type_code"
    case max_quantity = "max_quantity"
    case name = "name"
}

public enum ItemsRelationships: String {
    case options = "options"
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
    var item_type: String?

    @NSManaged open
    var item_type_code: String?

    @NSManaged open
    var max_quantity: Int32 // Optional scalars not supported

    @NSManaged open
    var name: String?

    // MARK: - Relationships

    @NSManaged open
    var options: NSSet

    open func optionsSet() -> NSMutableSet {
        return self.options.mutableCopy() as! NSMutableSet
    }

}

extension _Items {

    open func addOptions(_ objects: NSSet) {
        let mutable = self.options.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.options = mutable.copy() as! NSSet
    }

    open func removeOptions(_ objects: NSSet) {
        let mutable = self.options.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.options = mutable.copy() as! NSSet
    }

    open func addOptionsObject(_ value: Options) {
        let mutable = self.options.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.options = mutable.copy() as! NSSet
    }

    open func removeOptionsObject(_ value: Options) {
        let mutable = self.options.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.options = mutable.copy() as! NSSet
    }

}

