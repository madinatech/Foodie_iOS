// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AppExpires.swift instead.

import Foundation
import CoreData

public enum AppExpiresAttributes: String {
    case expires = "expires"
    case update_url = "update_url"
    case version = "version"
    case warning = "warning"
}

open class _AppExpires: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "AppExpires"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<AppExpires> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _AppExpires.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var expires: Date?

    @NSManaged open
    var update_url: String?

    @NSManaged open
    var version: String?

    @NSManaged open
    var warning: Date?

    // MARK: - Relationships

}

