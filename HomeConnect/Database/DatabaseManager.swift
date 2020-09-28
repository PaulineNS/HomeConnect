//
//  DataBaseManager.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation
import CoreData

open class DataBaseManager {

    // MARK: - Variables

    private let dataBaseStack: DataBaseStack
    private let managedObjectContext: NSManagedObjectContext

    var user: [UserAttributes] {
        let request: NSFetchRequest<UserAttributes> = UserAttributes.fetchRequest()
        guard let user = try? managedObjectContext.fetch(request) else { return [] }
        return user
    }

    var devices: [DeviceAttributes] {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
        guard let device = try? managedObjectContext.fetch(request) else { return [] }
        return device
    }

    func fetchDevicesDependingUser(user: UserAttributes) -> [DeviceAttributes] {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
        let predicate = NSPredicate(format: "owner == %@", user)
        request.predicate = predicate
        guard let devices = try? managedObjectContext.fetch(request) else { return [] }
        return devices
    }

//    var devices: [DeviceAttributes] {
//        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
//        guard let devices = try? managedObjectContext.fetch(request) else { return [] }
//        return devices
//    }
//
//    var users: [UserAttributes] {
//        let request: NSFetchRequest<UserAttributes> = UserAttributes.fetchRequest()
//        guard let users = try? managedObjectContext.fetch(request) else { return [] }
//        return users
//    }

    // MARK: - Initializer

    init(dataBaseStack: DataBaseStack) {
        self.dataBaseStack = dataBaseStack
        self.managedObjectContext = dataBaseStack.mainContext
    }

    func createDeviceEntity(deviceItem: DeviceItem, user: UserAttributes) {
        let device = DeviceAttributes(context: managedObjectContext)
        device.deviceId = deviceItem.idNumber
        device.intensity = deviceItem.intensity
        device.mode = deviceItem.mode
        device.name = deviceItem.deviceName
        device.position = deviceItem.position
        device.productType = deviceItem.productType?.rawValue
        device.temperature = deviceItem.temperature
        device.owner = user
        dataBaseStack.saveContext()
    }

    func createUserEntity(userItem: UserItem) {
        let user = UserAttributes(context: managedObjectContext)
        //todo convert date
        user.birthDate = Date(timeIntervalSince1970: 1432233446145.0/1000.0)
        user.city = userItem.city
        user.country = userItem.country
        user.firstName = userItem.firstName
        user.lastName = userItem.lastName
        user.postalCode = String(userItem.postalCode ?? 0)
        user.street = userItem.street
        user.streetCode = userItem.streetCode
        dataBaseStack.saveContext()
    }

    func deleteADevice(with deviceId: String) {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
        let predicateListName = NSPredicate(format: "deviceId == %@", deviceId)
        request.predicate = predicateListName

        if let objects = try? managedObjectContext.fetch(request) {
            objects.forEach { managedObjectContext.delete($0)}
        }
        dataBaseStack.saveContext()
    }

    func deleteAllDevices() {
        devices.forEach { managedObjectContext.delete($0) }
        dataBaseStack.saveContext()
    }

    func deleteAllUsers() {
        user.forEach { managedObjectContext.delete($0) }
        dataBaseStack.saveContext()
    }

}
