// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Cusines.swift instead.

import Foundation
import CoreData

public enum CusinesAttributes: String {
    case entity_id = "entity_id"
    case image = "image"
    case name = "name"
}

open class _Cusines: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Cusines"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Cusines> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Cusines.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var image: String?

    @NSManaged open
    var name: String?

    // MARK: - Relationships

}

