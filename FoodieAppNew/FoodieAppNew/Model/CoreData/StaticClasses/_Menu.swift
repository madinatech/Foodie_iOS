// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Menu.swift instead.

import Foundation
import CoreData

public enum MenuAttributes: String {
    case end_time = "end_time"
    case entity_id = "entity_id"
    case name = "name"
    case start_time = "start_time"
}

public enum MenuRelationships: String {
    case items = "items"
}

open class _Menu: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Menu"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Menu> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Menu.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var end_time: String?

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var name: String?

    @NSManaged open
    var start_time: String?

    // MARK: - Relationships

    @NSManaged open
    var items: NSSet

    open func itemsSet() -> NSMutableSet {
        return self.items.mutableCopy() as! NSMutableSet
    }

}

extension _Menu {

    open func addItems(_ objects: NSSet) {
        let mutable = self.items.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.items = mutable.copy() as! NSSet
    }

    open func removeItems(_ objects: NSSet) {
        let mutable = self.items.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.items = mutable.copy() as! NSSet
    }

    open func addItemsObject(_ value: Items) {
        let mutable = self.items.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.items = mutable.copy() as! NSSet
    }

    open func removeItemsObject(_ value: Items) {
        let mutable = self.items.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.items = mutable.copy() as! NSSet
    }

}

