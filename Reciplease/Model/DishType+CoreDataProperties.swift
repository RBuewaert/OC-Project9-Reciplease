//
//  DishType+CoreDataProperties.swift
//  Reciplease
//
//  Created by Romain Buewaert on 22/09/2021.
//
//

import Foundation
import CoreData


extension DishType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DishType> {
        return NSFetchRequest<DishType>(entityName: "DishType")
    }

    @NSManaged public var type: String?
    @NSManaged public var recipes: NSSet?

}

// MARK: Generated accessors for recipes
extension DishType {

    @objc(addRecipesObject:)
    @NSManaged public func addToRecipes(_ value: RecipeSaved)

    @objc(removeRecipesObject:)
    @NSManaged public func removeFromRecipes(_ value: RecipeSaved)

    @objc(addRecipes:)
    @NSManaged public func addToRecipes(_ values: NSSet)

    @objc(removeRecipes:)
    @NSManaged public func removeFromRecipes(_ values: NSSet)

}

extension DishType : Identifiable {

}
