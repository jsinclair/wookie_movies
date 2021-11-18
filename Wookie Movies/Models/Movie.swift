//
//  Movie.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import Foundation

struct Movie: Codable {
    let backdrop: String
    let cast: [String]
    let classification: String
    let directors: [String]
    let genres: [String]
    let id: String
    let imdbRating: Float
    let length: String
    let overview: String
    let poster: String
    let releasedOn: String
    let slug: String
    let title: String

    private enum CodingKeys: String, CodingKey {
        case backdrop, cast, classification, genres, id, length, overview, poster, slug, title
        case directors = "director"
        case imdbRating = "imdb_rating"
        case releasedOn = "released_on"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backdrop = try container.decode(String.self, forKey: .backdrop)
        self.cast = try container.decode([String].self, forKey: .cast)
        self.classification = try container.decode(String.self, forKey: .classification)
        if let singleDirector = try? container.decode(String.self, forKey: .directors) {
            self.directors = [singleDirector]
        } else {
            self.directors = try container.decode([String].self, forKey: .directors)
        }
        self.genres = try container.decode([String].self, forKey: .genres)
        self.id = try container.decode(String.self, forKey: .id)
        self.imdbRating = try container.decode(Float.self, forKey: .imdbRating)
        self.length = try container.decode(String.self, forKey: .length)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.poster = try container.decode(String.self, forKey: .poster)
        self.releasedOn = try container.decode(String.self, forKey: .releasedOn)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.title = try container.decode(String.self, forKey: .title)
    }
}
