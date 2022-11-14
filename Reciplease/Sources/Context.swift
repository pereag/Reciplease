//
//  Context.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/09/2022.
//

import Foundation

// Le sac a dos de dépendences
final class Context {
    let client: HTTPClientType
    let stack: CoreDataStack
    
    init() {
        client = HTTPClient()
        stack = CoreDataStack(modelName: "Reciplease", type: .prod)
    }
}
