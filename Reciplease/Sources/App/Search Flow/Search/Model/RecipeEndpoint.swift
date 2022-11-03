//
//  RecipeEndpoint.swift
//  Reciplease
//
//  Created by Valc0d3 on 05/09/2022.
//

import Foundation

struct RecipeEndpoint: Endpoint {
    var method: HTTPMethod
    var path: String
    var queryParameters: [String : Any]?

    init(ingredients: [String]) {
        self.method = .GET
        self.path = "https://api.edamam.com/api/recipes/v2"
        self.queryParameters = [
            "type": "public",
            "q": ingredients.joined(separator: ", "),
            "app_id": 71551821,
            "app_key": "da569260b8f4ee76006fd9ca98445bd8",
        ]
    }
}
