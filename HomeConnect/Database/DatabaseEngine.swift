//
//  DataBaseEngine.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation
import CoreData

open class DataBaseEngine {

    // MARK: - Properties

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

    // MARK: - Initializer

    init(dataBaseStack: DataBaseStack) {
        self.dataBaseStack = dataBaseStack
        self.managedObjectContext = dataBaseStack.mainContext
    }

    // MARK: - Public Methods

    func createDeviceEntity(deviceItem: DeviceItem) {
        let device = DeviceAttributes(context: managedObjectContext)
        device.deviceId = deviceItem.idNumber
        device.name = deviceItem.deviceName

        switch deviceItem.productType {
        case .heater(let mode, let temperature):
            device.productType = "Heater"
            device.mode = mode
            device.temperature = temperature
        case .light(let mode, let intensity):
            device.productType = "Light"
            device.mode = mode
            device.intensity = intensity
        case .rollerShutter(let position):
            device.productType = "RollerShutter"
            device.position = position
        }
        dataBaseStack.saveContext()
    }

    func createUserEntity(userItem: UserItem) {
        let user = UserAttributes(context: managedObjectContext)
        user.birthDate = userItem.birthDate
        user.city = userItem.city
        user.country = userItem.country
        user.firstName = userItem.firstName
        user.lastName = userItem.lastName
        user.postalCode = "\(userItem.postalCode ?? 0)"
        user.street = userItem.street
        user.streetCode = userItem.streetCode
        dataBaseStack.saveContext()
    }

    func deleteADevice(with deviceId: String) {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
        let predicateDeviceId = NSPredicate(format: "deviceId == %@", deviceId)
        request.predicate = predicateDeviceId

        if let objects = try? managedObjectContext.fetch(request) {
            objects.forEach { managedObjectContext.delete($0)}
        }
        dataBaseStack.saveContext()
    }

    func updateDeviceEntity(for deviceId: String,
                            mode: String? = "",
                            position: String? = "",
                            intensity: String? = "",
                            temperature: String? = "") {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
        let predicateDeviceId = NSPredicate(format: "deviceId == %@", deviceId)
        request.predicate = predicateDeviceId
        guard let devices = try? managedObjectContext.fetch(request) else { return }
        if devices.count != 0 {
            let managedObject = devices[0]
            managedObject.setValue(mode, forKey: "mode")
            managedObject.setValue(position, forKey: "position")
            managedObject.setValue(intensity, forKey: "intensity")
            managedObject.setValue(temperature, forKey: "temperature")
            dataBaseStack.saveContext()
        }
    }

    func updateUserEntity(firstName: String,
                          lastName: String,
                          streetNumber: String,
                          streetName: String,
                          postalCode: String,
                          city: String,
                          country: String,
                          birthdate: String) {
        let request: NSFetchRequest<UserAttributes> = UserAttributes.fetchRequest()
        guard let user = try? managedObjectContext.fetch(request).first else { return }
        let managedObject = user
        managedObject.setValue(firstName, forKey: "firstName")
        managedObject.setValue(lastName, forKey: "lastName")
        managedObject.setValue(streetNumber, forKey: "streetCode")
        managedObject.setValue(streetName, forKey: "street")
        managedObject.setValue(postalCode, forKey: "postalCode")
        managedObject.setValue(city, forKey: "city")
        managedObject.setValue(country, forKey: "country")
        managedObject.setValue(birthdate, forKey: "birthDate")
        dataBaseStack.saveContext()
    }

    func fetchDevicesWithFilters() -> [DeviceAttributes] {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()

        let predicate = NSPredicate(format: "productType == %@", "Light")
        request.predicate = predicate

        guard let device = try? managedObjectContext.fetch(request) else { return [] }
        return device

    }
}
