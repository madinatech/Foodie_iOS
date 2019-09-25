// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GroupValues.swift instead.

import Foundation
import CoreData

public enum GroupValuesAttributes: String {
    case item_name = "item_name"
    case price = "price"
}

open class _GroupValues: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "GroupValues"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<GroupValues> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _GroupValues.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var item_name: String?

    @NSManaged open
    var price: Int32 // Optional scalars not supported

    // MARK: - Relationships

}

