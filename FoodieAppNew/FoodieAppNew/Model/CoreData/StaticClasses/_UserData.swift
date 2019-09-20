// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserData.swift instead.

import Foundation
import CoreData

public enum UserDataRelationships: String {
    case delivery_options = "delivery_options"
    case payment_options = "payment_options"
}

open class _UserData: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "UserData"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _UserData.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    // MARK: - Relationships

    @NSManaged open
    var delivery_options: NSSet

    open func delivery_optionsSet() -> NSMutableSet {
        return self.delivery_options.mutableCopy() as! NSMutableSet
    }

    @NSManaged open
    var payment_options: NSSet

    open func payment_optionsSet() -> NSMutableSet {
        return self.payment_options.mutableCopy() as! NSMutableSet
    }

}

extension _UserData {

    open func addDelivery_options(_ objects: NSSet) {
        let mutable = self.delivery_options.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.delivery_options = mutable.copy() as! NSSet
    }

    open func removeDelivery_options(_ objects: NSSet) {
        let mutable = self.delivery_options.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.delivery_options = mutable.copy() as! NSSet
    }

    open func addDelivery_optionsObject(_ value: DeliveryOption) {
        let mutable = self.delivery_options.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.delivery_options = mutable.copy() as! NSSet
    }

    open func removeDelivery_optionsObject(_ value: DeliveryOption) {
        let mutable = self.delivery_options.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.delivery_options = mutable.copy() as! NSSet
    }

}

extension _UserData {

    open func addPayment_options(_ objects: NSSet) {
        let mutable = self.payment_options.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.payment_options = mutable.copy() as! NSSet
    }

    open func removePayment_options(_ objects: NSSet) {
        let mutable = self.payment_options.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.payment_options = mutable.copy() as! NSSet
    }

    open func addPayment_optionsObject(_ value: PaymentOption) {
        let mutable = self.payment_options.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.payment_options = mutable.copy() as! NSSet
    }

    open func removePayment_optionsObject(_ value: PaymentOption) {
        let mutable = self.payment_options.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.payment_options = mutable.copy() as! NSSet
    }

}

