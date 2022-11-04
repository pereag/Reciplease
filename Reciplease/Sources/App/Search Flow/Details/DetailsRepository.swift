//
//  DetailsRepository.swift
//  Reciplease
//
//  Created by Valc0d3 on 17/10/2022.
//

import Foundation


class DetailsRepository : DetailsRepositoryType {
    func checkIfIsFavorite() -> Bool {
        return true
    }
    
    func addToFavorites(recipe: Recipe) {
        print("Add favorite")
        
    }
    
    func removeFromFavorites(url: String) {
        print("remove favorite")
    }
    
    
}

protocol DetailsRepositoryType {
    func checkIfIsFavorite() -> Bool
    func addToFavorites(recipe: Recipe)
    func removeFromFavorites(url: String)
}
