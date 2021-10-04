//
//  TestCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Romain Buewaert on 01/10/2021.
//

import Foundation
import UIKit
import CoreData
import Reciplease

class TestCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")
//        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
