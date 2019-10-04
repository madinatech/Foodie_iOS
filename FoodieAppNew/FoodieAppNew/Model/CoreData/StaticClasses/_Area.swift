// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Area.swift instead.

import Foundation
import CoreData

public enum AreaAttributes: String {
    case entity_id = "entity_id"
    case is_selected = "is_selected"
    case name = "name"
}

open class _Area: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Area"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Area> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Area.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var is_selected: Bool // Optional scalars not supported

    @NSManaged open
    var name: String?

    // MARK: - Relationships

}

