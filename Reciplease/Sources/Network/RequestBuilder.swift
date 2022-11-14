//
//  RequestBuilder.swift
//  Reciplease
//
//  Created by Valc0d3 on 02/09/2022.
//

import Foundation

final class RequestBuilder {
    
    // MARK: - Build
    
    func build(from endpoint: Endpoint) -> URLRequest? {
        guard let url = url(from: endpoint.path, queryParameters: endpoint.queryParameters) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        return request
    }
    
    // MARK: - Helper
    
    private func url(from path: String, queryParameters: [String: Any]?) -> URL? {
        guard var components = URLComponents(string: path) else {
            return nil
        }
        
        guard let queryParameters = queryParameters else {
            return components.url
        }
        
        components.queryItems = queryParameters
            .map({ (key, value) -> (String, String) in
                return (key, "\(value)")
            })
            .map { URLQueryItem(name: $0, value: $1) }
        
        return components.url
    }
}
