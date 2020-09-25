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

    func fetchDevicesDependingUser(user: UserAttributes) -> [DeviceAttributes] {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
        let predicate = NSPredicate(format: "owner == %@", user)
        request.predicate = predicate
        guard let devices = try? managedObjectContext.fetch(request) else { return [] }
        return devices
    }

    var devices: [DeviceAttributes] {
        let request: NSFetchRequest<DeviceAttributes> = DeviceAttributes.fetchRequest()
        guard let devices = try? managedObjectContext.fetch(request) else { return [] }
        return devices
    }

    var users: [UserAttributes] {
        let request: NSFetchRequest<UserAttributes> = UserAttributes.fetchRequest()
        guard let users = try? managedObjectContext.fetch(request) else { return [] }
        return users
    }

    // MARK: - Initializer

    init(dataBaseStack: DataBaseStack) {
        self.dataBaseStack = dataBaseStack
        self.managedObjectContext = dataBaseStack.mainContext
    }

}
