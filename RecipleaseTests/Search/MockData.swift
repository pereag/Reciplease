//
//  MockData.swift
//  RecipleaseTests
//
//  Created by Valc0d3 on 17/10/2022.
//

import Foundation

enum MockData {
    static var recipeData: Data {
        let path = Bundle.test.path(forResource: "RecipeResponse", ofType: ".json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}


public extension Bundle {
    class var test: Bundle {
        return Bundle(for: BundleFinder.self)
    }
}

private class BundleFinder {}
