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
            let deviceMode = temperature == "0" ? "OFF" : mode
            device.mode = deviceMode
            let deviceTemperature = mode == "OFF" ? "0" : temperature
            device.temperature = deviceTemperature
        case .light(let mode, let intensity):
            device.productType = "Light"
            let deviceMode = intensity == "0" ? "OFF" : mode
            device.mode = deviceMode
            let deviceIntensity = mode == "OFF" ? "0" : intensity
            device.intensity = deviceIntensity
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

    func updateUserEntity(userItem: UserItem, birthdate: String) {
        let request: NSFetchRequest<UserAttributes> = UserAttributes.fetchRequest()
        guard let user = try? managedObjectContext.fetch(request).first else { return }
        let managedObject = user
        managedObject.setValue(userItem.firstName, forKey: "firstName")
        managedObject.setValue(userItem.lastName, forKey: "lastName")
        managedObject.setValue(userItem.streetCode, forKey: "streetCode")
        managedObject.setValue(userItem.street, forKey: "street")
        managedObject.setValue(String(userItem.postalCode ?? 0), forKey: "postalCode")
        managedObject.setValue(userItem.city, forKey: "city")
        managedObject.setValue(userItem.country, forKey: "country")
        managedObject.setValue(birthdate, forKey: "birthDate")
        dataBaseStack.saveContext()
    }

    func fetchDevicesWithFilters(productType: String,
                                 mode: String? = nil,
                                 settings: String,
                                 settingsValue: String) -> [DeviceAttributes] {
        guard let mode = mode else {
            return fetchDevicesWithTwoPredicates(productType: productType,
                                                 settings: settings,
                                                 settingsValue: settingsValue)
        }
        return fetchDevicesWithThreePredicates(productType: productType,
                                               mode: mode,
                                               settings: settings,
                                               settingsValue: settingsValue)
    }

    private func fetchDevicesWithTwoPredicates(productType: String,
                                               settings: String,
                                               settingsValue: String) -> [DeviceAttributes] {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
        let productTypePredicate = NSPredicate(format: "productType == %@", productType)
        let settingsPredicate = NSPredicate(format: "\(settings) == %@", settingsValue)
        let andPredicate = NSCompoundPredicate(type: .and,
                                               subpredicates: [productTypePredicate, settingsPredicate])
        request.predicate = andPredicate
        guard let device = try? managedObjectContext.fetch(request) else {
            return []
        }
        return device
    }

    private func fetchDevicesWithThreePredicates(productType: String,
                                                 mode: String,
                                                 settings: String,
                                                 settingsValue: String) -> [DeviceAttributes] {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
        let productTypePredicate = NSPredicate(format: "productType == %@", productType)
        let modePredicate = NSPredicate(format: "mode == %@", mode)
        let settingsPredicate = NSPredicate(format: "\(settings) == %@", settingsValue)
        let andPredicate = NSCompoundPredicate(type: .and,
                                               subpredicates: [productTypePredicate, modePredicate, settingsPredicate])
        request.predicate = andPredicate
        guard let device = try? managedObjectContext.fetch(request) else {
            return []
        }
        return device
    }
}
