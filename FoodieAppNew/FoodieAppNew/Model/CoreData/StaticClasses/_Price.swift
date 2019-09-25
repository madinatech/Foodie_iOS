// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Price.swift instead.

import Foundation
import CoreData

public enum PriceAttributes: String {
    case price = "price"
    case valid_from = "valid_from"
    case valid_to = "valid_to"
}

open class _Price: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Price"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Price> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Price.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var price: Int32 // Optional scalars not supported

    @NSManaged open
    var valid_from: Date?

    @NSManaged open
    var valid_to: Date?

    // MARK: - Relationships

}

