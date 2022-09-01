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

    init(client: HTTPClientType) {
        self.client = client
    }

    func getRecipe(for ingredients: [String], callback: @escaping (Result<RecipeResponse, Error>) -> Void) {
        let request = URLRequest(url: URL(string: "")!)
        client.send(request: request, token: token, callback: { result in
            switch result {
            case let .success(data):
                guard let response: Result<RecipeResponse, Error> = try? self.parser.processCodableResponse(from: data) else { return }
                callback(response)
            case let .failure(error):
                callback(.failure(error))
            }
        })
    }
}
