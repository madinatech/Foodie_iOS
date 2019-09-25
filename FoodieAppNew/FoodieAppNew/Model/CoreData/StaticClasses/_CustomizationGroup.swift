// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CustomizationGroup.swift instead.

import Foundation
import CoreData

public enum CustomizationGroupAttributes: String {
    case entity_id = "entity_id"
    case group_name = "group_name"
    case group_type = "group_type"
    case group_type_code = "group_type_code"
    case select_max = "select_max"
}

public enum CustomizationGroupRelationships: String {
    case group_values = "group_values"
}

open class _CustomizationGroup: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "CustomizationGroup"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<CustomizationGroup> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _CustomizationGroup.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var group_name: String?

    @NSManaged open
    var group_type: String?

    @NSManaged open
    var group_type_code: String?

    @NSManaged open
    var select_max: Int32 // Optional scalars not supported

    // MARK: - Relationships

    @NSManaged open
    var group_values: NSSet

    open func group_valuesSet() -> NSMutableSet {
        return self.group_values.mutableCopy() as! NSMutableSet
    }

}

extension _CustomizationGroup {

    open func addGroup_values(_ objects: NSSet) {
        let mutable = self.group_values.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.group_values = mutable.copy() as! NSSet
    }

    open func removeGroup_values(_ objects: NSSet) {
        let mutable = self.group_values.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.group_values = mutable.copy() as! NSSet
    }

    open func addGroup_valuesObject(_ value: GroupValues) {
        let mutable = self.group_values.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.group_values = mutable.copy() as! NSSet
    }

    open func removeGroup_valuesObject(_ value: GroupValues) {
        let mutable = self.group_values.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.group_values = mutable.copy() as! NSSet
    }

}

