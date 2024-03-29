// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Location.swift instead.

import Foundation
import CoreData

public enum LocationAttributes: String {
    case address1 = "address1"
    case address2 = "address2"
    case city = "city"
    case country = "country"
    case lat = "lat"
    case lng = "lng"
}

open class _Location: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Location"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Location.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var address1: String?

    @NSManaged open
    var address2: String?

    @NSManaged open
    var city: String?

    @NSManaged open
    var country: String?

    @NSManaged open
    var lat: String?

    @NSManaged open
    var lng: String?

    // MARK: - Relationships

}

