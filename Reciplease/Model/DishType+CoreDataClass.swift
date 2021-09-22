//
//  DishType+CoreDataClass.swift
//  Reciplease
//
//  Created by Romain Buewaert on 22/09/2021.
//
//

import Foundation
import CoreData


public class DishType: NSManagedObject {
    static var all: [DishType] {
        let request: NSFetchRequest<DishType> = DishType.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "type", ascending: true),
            NSSortDescriptor(key: "type.recipes", ascending: true)
        ]
        guard let dishTypes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return dishTypes
    }
}
