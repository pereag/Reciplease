//
//  Endpoint.swift
//  Reciplease
//
//  Created by Valc0d3 on 02/09/2022.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol Endpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParameters: [String: Any]? { get }
}
