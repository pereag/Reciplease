//
//  SearchRepository.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import Foundation

struct RecipeResponse {}

protocol SearchRepositoryType {
    func getRecipe(for ingredients: [String], callback: (Result<RecipeResponse, Error>) -> Void)
}

final class SearchRepository: SearchRepositoryType {
    

//    private let network: NetworkType
//
//    init(network: NetworkType) {
//        self.network = network
//    }
//
    func getRecipe(for ingredients: [String], callback: (Result<RecipeResponse, Error>) -> Void) {
        // TODO :)
    }
}
