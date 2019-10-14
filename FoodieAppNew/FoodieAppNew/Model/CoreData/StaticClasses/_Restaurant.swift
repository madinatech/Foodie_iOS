// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Restaurant.swift instead.

import Foundation
import CoreData

public enum RestaurantAttributes: String {
    case area = "area"
    case average_rating = "average_rating"
    case cost_for_two = "cost_for_two"
    case delivery_time = "delivery_time"
    case email = "email"
    case entity_id = "entity_id"
    case isFavorite = "isFavorite"
    case is_closed = "is_closed"
    case name = "name"
    case phone = "phone"
    case preparation_time = "preparation_time"
    case service_area = "service_area"
    case status = "status"
}

public enum RestaurantRelationships: String {
    case cuisines = "cuisines"
    case images = "images"
    case location = "location"
    case menus = "menus"
    case offerings = "offerings"
    case opening_times = "opening_times"
}

open class _Restaurant: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Restaurant"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Restaurant.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var area: String?

    @NSManaged open
    var average_rating: Double // Optional scalars not supported

    @NSManaged open
    var cost_for_two: Int32 // Optional scalars not supported

    @NSManaged open
    var delivery_time: Int32 // Optional scalars not supported

    @NSManaged open
    var email: String?

    @NSManaged open
    var entity_id: Int32 // Optional scalars not supported

    @NSManaged open
    var isFavorite: Bool // Optional scalars not supported

    @NSManaged open
    var is_closed: Bool // Optional scalars not supported

    @NSManaged open
    var name: String?

    @NSManaged open
    var phone: String?

    @NSManaged open
    var preparation_time: Int32 // Optional scalars not supported

    @NSManaged open
    var service_area: String?

    @NSManaged open
    var status: String?

    // MARK: - Relationships

    @NSManaged open
    var cuisines: NSSet

    open func cuisinesSet() -> NSMutableSet {
        return self.cuisines.mutableCopy() as! NSMutableSet
    }

    @NSManaged open
    var images: Images?

    @NSManaged open
    var location: Location?

    @NSManaged open
    var menus: NSSet

    open func menusSet() -> NSMutableSet {
        return self.menus.mutableCopy() as! NSMutableSet
    }

    @NSManaged open
    var offerings: Offerings?

    @NSManaged open
    var opening_times: NSSet

    open func opening_timesSet() -> NSMutableSet {
        return self.opening_times.mutableCopy() as! NSMutableSet
    }

}

extension _Restaurant {

    open func addCuisines(_ objects: NSSet) {
        let mutable = self.cuisines.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.cuisines = mutable.copy() as! NSSet
    }

    open func removeCuisines(_ objects: NSSet) {
        let mutable = self.cuisines.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.cuisines = mutable.copy() as! NSSet
    }

    open func addCuisinesObject(_ value: Cusines) {
        let mutable = self.cuisines.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.cuisines = mutable.copy() as! NSSet
    }

    open func removeCuisinesObject(_ value: Cusines) {
        let mutable = self.cuisines.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.cuisines = mutable.copy() as! NSSet
    }

}

extension _Restaurant {

    open func addMenus(_ objects: NSSet) {
        let mutable = self.menus.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.menus = mutable.copy() as! NSSet
    }

    open func removeMenus(_ objects: NSSet) {
        let mutable = self.menus.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.menus = mutable.copy() as! NSSet
    }

    open func addMenusObject(_ value: Menu) {
        let mutable = self.menus.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.menus = mutable.copy() as! NSSet
    }

    open func removeMenusObject(_ value: Menu) {
        let mutable = self.menus.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.menus = mutable.copy() as! NSSet
    }

}

extension _Restaurant {

    open func addOpening_times(_ objects: NSSet) {
        let mutable = self.opening_times.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.opening_times = mutable.copy() as! NSSet
    }

    open func removeOpening_times(_ objects: NSSet) {
        let mutable = self.opening_times.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.opening_times = mutable.copy() as! NSSet
    }

    open func addOpening_timesObject(_ value: OpeningTimes) {
        let mutable = self.opening_times.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.opening_times = mutable.copy() as! NSSet
    }

    open func removeOpening_timesObject(_ value: OpeningTimes) {
        let mutable = self.opening_times.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.opening_times = mutable.copy() as! NSSet
    }

}

