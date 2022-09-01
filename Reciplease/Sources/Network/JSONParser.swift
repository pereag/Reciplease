//
//  JSONParser.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/09/2022.
//

import Foundation

final class JSONParser {
    func processCodableResponse<C: Codable>(from data: Data) throws -> Result<C, Error> {
        do {
            let object = try JSONDecoder().decode(C.self, from: data)
            return .success(object)
        } catch let error {
            return .failure(error)
        }
    }
}
