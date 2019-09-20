// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DeliveryOption.swift instead.

import Foundation
import CoreData

public enum DeliveryOptionAttributes: String {
    case address = "address"
    case entity_id = "entity_id"
    case img = "img"
    case latitude = "latitude"
    case longitude = "longitude"
    case method = "method"
    case rate = "rate"
}

open class _DeliveryOption: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "DeliveryOption"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<DeliveryOption> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _DeliveryOption.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var address: String?

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var img: String?

    @NSManaged open
    var latitude: String?

    @NSManaged open
    var longitude: String?

    @NSManaged open
    var method: String?

    @NSManaged open
    var rate: Int32 // Optional scalars not supported

    // MARK: - Relationships

}

