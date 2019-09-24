// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OpeningTimes.swift instead.

import Foundation
import CoreData

public enum OpeningTimesAttributes: String {
    case closing_time = "closing_time"
    case day = "day"
    case open_status = "open_status"
    case opening_time = "opening_time"
}

open class _OpeningTimes: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "OpeningTimes"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<OpeningTimes> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _OpeningTimes.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var closing_time: String?

    @NSManaged open
    var day: String?

    @NSManaged open
    var open_status: String?

    @NSManaged open
    var opening_time: String?

    // MARK: - Relationships

}

