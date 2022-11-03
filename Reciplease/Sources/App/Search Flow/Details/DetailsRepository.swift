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
    
    func addToFavorites() {
   
    }
    
    func removeFromFavorites() {

    }
    
    
}

protocol DetailsRepositoryType {
    func checkIfIsFavorite() -> Bool
    func addToFavorites()
    func removeFromFavorites()
}
