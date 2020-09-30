//
//  MockDataBaseStack.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 30/09/2020.
//

import Foundation
import HomeConnect
import CoreData

final class MockDataBaseStack: DataBaseStack {

    // MARK: - Initializer

    convenience init() {
        self.init(modelName: "HomeConnect")
    }

    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }

}
