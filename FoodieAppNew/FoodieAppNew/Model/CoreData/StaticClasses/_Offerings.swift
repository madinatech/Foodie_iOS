// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Offerings.swift instead.

import Foundation
import CoreData

public enum OfferingsAttributes: String {
    case collection = "collection"
    case delivery = "delivery"
    case dine_in = "dine_in"
}

open class _Offerings: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Offerings"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Offerings> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Offerings.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var collection: Bool // Optional scalars not supported

    @NSManaged open
    var delivery: Bool // Optional scalars not supported

    @NSManaged open
    var dine_in: Bool // Optional scalars not supported

    // MARK: - Relationships

}

