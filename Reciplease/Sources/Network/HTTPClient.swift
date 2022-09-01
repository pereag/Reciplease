//
//  HTTPClient.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/09/2022.
//

import Foundation

protocol HTTPClientType {
    func send(request: URLRequest, token: RequestCancellationToken, callback: @escaping (Result<Data, Error>) -> Void)
}

final class HTTPClient: HTTPClientType {
    func send(request: URLRequest, token: RequestCancellationToken, callback: @escaping (Result<Data, Error>) -> Void) {
        
    }
}
