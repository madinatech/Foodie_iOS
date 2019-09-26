// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Favourite.swift instead.

import Foundation
import CoreData

public enum FavouriteAttributes: String {
    case created_at = "created_at"
    case favourite_id = "favourite_id"
}

public enum FavouriteRelationships: String {
    case restaurant = "restaurant"
}

open class _Favourite: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Favourite"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Favourite.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var created_at: Date?

    @NSManaged open
    var favourite_id: Int32 // Optional scalars not supported

    // MARK: - Relationships

    @NSManaged open
    var restaurant: NSSet

    open func restaurantSet() -> NSMutableSet {
        return self.restaurant.mutableCopy() as! NSMutableSet
    }

}

extension _Favourite {

    open func addRestaurant(_ objects: NSSet) {
        let mutable = self.restaurant.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.restaurant = mutable.copy() as! NSSet
    }

    open func removeRestaurant(_ objects: NSSet) {
        let mutable = self.restaurant.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.restaurant = mutable.copy() as! NSSet
    }

    open func addRestaurantObject(_ value: Restaurant) {
        let mutable = self.restaurant.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.restaurant = mutable.copy() as! NSSet
    }

    open func removeRestaurantObject(_ value: Restaurant) {
        let mutable = self.restaurant.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.restaurant = mutable.copy() as! NSSet
    }

}

