// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Country.swift instead.

import Foundation
import CoreData

public enum CountryAttributes: String {
    case country_id = "country_id"
    case country_name = "country_name"
}

public enum CountryRelationships: String {
    case cities = "cities"
}

open class _Country: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Country"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Country.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var country_id: Int32 // Optional scalars not supported

    @NSManaged open
    var country_name: String?

    // MARK: - Relationships

    @NSManaged open
    var cities: NSSet

    open func citiesSet() -> NSMutableSet {
        return self.cities.mutableCopy() as! NSMutableSet
    }

}

extension _Country {

    open func addCities(_ objects: NSSet) {
        let mutable = self.cities.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.cities = mutable.copy() as! NSSet
    }

    open func removeCities(_ objects: NSSet) {
        let mutable = self.cities.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.cities = mutable.copy() as! NSSet
    }

    open func addCitiesObject(_ value: City) {
        let mutable = self.cities.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.cities = mutable.copy() as! NSSet
    }

    open func removeCitiesObject(_ value: City) {
        let mutable = self.cities.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.cities = mutable.copy() as! NSSet
    }

}

