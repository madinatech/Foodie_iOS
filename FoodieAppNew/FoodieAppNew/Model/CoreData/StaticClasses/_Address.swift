// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Address.swift instead.

import Foundation
import CoreData

public enum AddressAttributes: String {
    case address = "address"
    case address_type = "address_type"
    case city = "city"
    case country = "country"
    case created_at = "created_at"
    case entity_id = "entity_id"
    case floor = "floor"
    case house_number = "house_number"
    case is_default = "is_default"
    case is_selected = "is_selected"
    case landmark = "landmark"
    case latitude = "latitude"
    case longitude = "longitude"
    case status = "status"
    case street = "street"
    case town = "town"
    case updated_at = "updated_at"
    case user_id = "user_id"
}

open class _Address: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Address"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Address.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var address: String?

    @NSManaged open
    var address_type: String?

    @NSManaged open
    var city: String?

    @NSManaged open
    var country: Int32 // Optional scalars not supported

    @NSManaged open
    var created_at: Date?

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var floor: String?

    @NSManaged open
    var house_number: String?

    @NSManaged open
    var is_default: Int32 // Optional scalars not supported

    @NSManaged open
    var is_selected: Bool // Optional scalars not supported

    @NSManaged open
    var landmark: String?

    @NSManaged open
    var latitude: String?

    @NSManaged open
    var longitude: String?

    @NSManaged open
    var status: String?

    @NSManaged open
    var street: String?

    @NSManaged open
    var town: String?

    @NSManaged open
    var updated_at: Date?

    @NSManaged open
    var user_id: Int32 // Optional scalars not supported

    // MARK: - Relationships

}

