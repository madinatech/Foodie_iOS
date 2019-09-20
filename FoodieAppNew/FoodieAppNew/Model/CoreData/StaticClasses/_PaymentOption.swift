// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PaymentOption.swift instead.

import Foundation
import CoreData

public enum PaymentOptionAttributes: String {
    case entity_id = "entity_id"
    case img = "img"
    case method = "method"
}

open class _PaymentOption: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "PaymentOption"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<PaymentOption> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _PaymentOption.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var img: String?

    @NSManaged open
    var method: String?

    // MARK: - Relationships

}

