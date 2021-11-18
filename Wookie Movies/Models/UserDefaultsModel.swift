//
//  UserDefaultsModel.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/18.
//

import Foundation

enum UserDefaultsKeys: String {
    case favourite, watched
}

class UserDefaultsModel {
    private static let instance = UserDefaultsModel()

    static func getInstance() -> UserDefaultsModel {
        return instance
    }

    private let userDefaults: UserDefaults
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder

    private init() {
        userDefaults = UserDefaults.standard
        jsonEncoder = JSONEncoder()
        jsonDecoder = JSONDecoder()
    }

    func add(movie: Movie, for key: UserDefaultsKeys) {
        var movies = movies(for: key)

        if movies.contains(where: { $0.id == movie.id }) {
            return
        }

        movies.append(movie)
        movies.sort(by: { $0.title < $1.title })

        save(movies: movies, for: key)
    }

    func remove(movie: Movie, for key: UserDefaultsKeys) {
        var movies = movies(for: key)

        if movies.contains(where: { $0.id == movie.id }) {
            movies.removeAll(where: { $0.id == movie.id })
            save(movies: movies, for: key)
        }
    }

    func save(movies: [Movie], for key: UserDefaultsKeys) {
        userDefaults.set(try? jsonEncoder.encode(movies), forKey: key.rawValue)
    }

    func movies(for key: UserDefaultsKeys) -> [Movie] {
        guard let encodedData = userDefaults.data(forKey: key.rawValue) else {
            return []
        }

        return (try? jsonDecoder.decode([Movie].self, from: encodedData)) ?? []
    }
}
