// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Options.swift instead.

import Foundation
import CoreData

public enum OptionsAttributes: String {
    case added_price = "added_price"
    case entity_id = "entity_id"
    case option_key = "option_key"
    case option_type = "option_type"
    case option_type_code = "option_type_code"
    case option_value = "option_value"
}

open class _Options: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Options"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Options> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Options.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var added_price: Int32 // Optional scalars not supported

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var option_key: String?

    @NSManaged open
    var option_type: String?

    @NSManaged open
    var option_type_code: String?

    @NSManaged open
    var option_value: String?

    // MARK: - Relationships

}

