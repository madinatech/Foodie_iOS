// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LocalCart.swift instead.

import Foundation
import CoreData

public enum LocalCartAttributes: String {
    case added_date = "added_date"
    case item_id = "item_id"
    case item_name = "item_name"
    case item_price = "item_price"
    case item_quantity = "item_quantity"
    case restaurant_id = "restaurant_id"
}

open class _LocalCart: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "LocalCart"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<LocalCart> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _LocalCart.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var added_date: Date?

    @NSManaged open
    var item_id: Int32 // Optional scalars not supported

    @NSManaged open
    var item_name: String?

    @NSManaged open
    var item_price: Int32 // Optional scalars not supported

    @NSManaged open
    var item_quantity: Int32 // Optional scalars not supported

    @NSManaged open
    var restaurant_id: Int32 // Optional scalars not supported

    // MARK: - Relationships

}

