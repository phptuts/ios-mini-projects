//
//  Model.swift
//  DogApiApp
//
//  Created by Noah Glaser on 7/5/22.
//

import Foundation

// https://dog.ceo/dog-api/documentation/random

struct BreedResponse: Codable {
    var message: [String: [String]]
    var status: String
}

struct SingleImageResponse: Codable {
    var message: String
    var status: String
}

enum UrlError: Error {
    case badUrl
}


func getData<T: Codable>(urlString: String) async throws -> T  {
    guard let url = URL(string: urlString) else {
        throw UrlError.badUrl
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(T.self, from: data)
}

