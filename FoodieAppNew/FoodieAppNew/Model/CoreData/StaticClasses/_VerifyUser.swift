// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to VerifyUser.swift instead.

import Foundation
import CoreData

public enum VerifyUserAttributes: String {
    case email = "email"
    case entity_id = "entity_id"
    case name = "name"
    case phone = "phone"
}

public enum VerifyUserRelationships: String {
    case app_expires = "app_expires"
    case userData = "userData"
}

open class _VerifyUser: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "VerifyUser"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<VerifyUser> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _VerifyUser.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var email: String?

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var name: String?

    @NSManaged open
    var phone: String?

    // MARK: - Relationships

    @NSManaged open
    var app_expires: AppExpires?

    @NSManaged open
    var userData: UserData?

}

