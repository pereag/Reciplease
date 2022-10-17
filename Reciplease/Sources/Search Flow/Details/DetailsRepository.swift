//
//  DetailsRepository.swift
//  Reciplease
//
//  Created by Valc0d3 on 17/10/2022.
//

import Foundation

protocol DetailsRepositoryType {
    func checkIfIsFavorite() -> Bool
    func addToFavorites()
    func removeFromFavorites()
}
