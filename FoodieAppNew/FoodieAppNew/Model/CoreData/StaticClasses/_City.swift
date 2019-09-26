// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to City.swift instead.

import Foundation
import CoreData

public enum CityAttributes: String {
    case city_id = "city_id"
    case city_name = "city_name"
}

public enum CityRelationships: String {
    case areas = "areas"
}

open class _City: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "City"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _City.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var city_id: Int32 // Optional scalars not supported

    @NSManaged open
    var city_name: String?

    // MARK: - Relationships

    @NSManaged open
    var areas: NSSet

    open func areasSet() -> NSMutableSet {
        return self.areas.mutableCopy() as! NSMutableSet
    }

}

extension _City {

    open func addAreas(_ objects: NSSet) {
        let mutable = self.areas.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.areas = mutable.copy() as! NSSet
    }

    open func removeAreas(_ objects: NSSet) {
        let mutable = self.areas.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.areas = mutable.copy() as! NSSet
    }

    open func addAreasObject(_ value: Area) {
        let mutable = self.areas.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.areas = mutable.copy() as! NSSet
    }

    open func removeAreasObject(_ value: Area) {
        let mutable = self.areas.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.areas = mutable.copy() as! NSSet
    }

}

