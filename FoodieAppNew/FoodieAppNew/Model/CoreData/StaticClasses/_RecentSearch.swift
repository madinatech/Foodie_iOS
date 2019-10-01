// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RecentSearch.swift instead.

import Foundation
import CoreData

public enum RecentSearchAttributes: String {
    case added_date = "added_date"
    case name = "name"
}

open class _RecentSearch: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "RecentSearch"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<RecentSearch> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _RecentSearch.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var added_date: Date?

    @NSManaged open
    var name: String?

    // MARK: - Relationships

}

