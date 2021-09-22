//
//  RecipeSaved+CoreDataProperties.swift
//  Reciplease
//
//  Created by Romain Buewaert on 22/09/2021.
//
//

import Foundation
import CoreData


extension RecipeSaved {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeSaved> {
        return NSFetchRequest<RecipeSaved>(entityName: "RecipeSaved")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var ingredientList: String?
    @NSManaged public var note: Int16
    @NSManaged public var title: String?
    @NSManaged public var totalTime: Double
    @NSManaged public var url: String?
    @NSManaged public var dishTypes: NSSet?

    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
}

// MARK: Generated accessors for dishTypes
extension RecipeSaved {

    @objc(addDishTypesObject:)
    @NSManaged public func addToDishTypes(_ value: DishType)

    @objc(removeDishTypesObject:)
    @NSManaged public func removeFromDishTypes(_ value: DishType)

    @objc(addDishTypes:)
    @NSManaged public func addToDishTypes(_ values: NSSet)

    @objc(removeDishTypes:)
    @NSManaged public func removeFromDishTypes(_ values: NSSet)

}

extension RecipeSaved : Identifiable {

}
