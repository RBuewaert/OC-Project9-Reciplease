//
//  ErrorType.swift
//  Reciplease
//
//  Created by Romain Buewaert on 15/09/2021.
//

import Foundation

enum ErrorType: String, Error {
    case downloadFailed = "The download failed"
    case noData = "no data found"
    case extractValues = "No possible to extract values"
    case noResult = "there is no recipe found for this research"
    case saveFailed = "Favorite not saved"
    case deletionFailed = "Favorite not removed"
}
