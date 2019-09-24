// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Images.swift instead.

import Foundation
import CoreData

public enum ImagesAttributes: String {
    case banner = "banner"
    case display = "display"
}

open class _Images: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Images"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Images> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Images.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var banner: String?

    @NSManaged open
    var display: String?

    // MARK: - Relationships

}

