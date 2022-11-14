//
//  SearchRepository.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import Foundation

protocol SearchRepositoryType {
    func getRecipe(for ingredients: [String], callback: @escaping (Result<RecipeResponse, Error>) -> Void)
}

final class SearchRepository: SearchRepositoryType {
    
    private let client: HTTPClientType
    private let token = RequestCancellationToken()
    private let parser = JSONParser()
    private let bulder = RequestBuilder()
    
    init(client: HTTPClientType) {
        self.client = client
    }
    
    func getRecipe(for ingredients: [String], callback: @escaping (Result<RecipeResponse, Error>) -> Void) {
        let endpoint = RecipeEndpoint(ingredients: ingredients)
        guard let request = bulder.build(from: endpoint) else { return }
        
        client.send(request: request, token: token, completionHandler: { result in
            switch result {
            case let .success(data):
                do {
                    let response: Result<RecipeResponse, Error> = try self.parser.processCodableResponse(from: data) 
                    callback(response)
                } catch let error {
                    callback(.failure(error))
                }
                
            case let .failure(error):
                callback(.failure(error))
            }
        })
    }
}
