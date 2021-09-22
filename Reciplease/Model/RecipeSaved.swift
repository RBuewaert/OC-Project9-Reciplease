//
//  RecipeSaved.swift
//  Reciplease
//
//  Created by Romain Buewaert on 20/09/2021.
//

import Foundation
import CoreData

class RecipeSaved: NSManagedObject {
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }

    public var wrappedImageUrl: String {
        imageUrl ?? "Unknown Title"
    }

}
