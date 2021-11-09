//
//  Movie.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import Foundation

struct Movie: Decodable {
    let backdrop: String
    let cast: [String]
    let classification: String
    let director: String
    let genres: [String]
    let id: String
    // swiftlint:disable:next identifier_name
    let imdb_rating: Float
    let length: String
    let overview: String
    let poster: String
    // swiftlint:disable:next identifier_name
    let released_on: String
    let slug: String
    let title: String
}
