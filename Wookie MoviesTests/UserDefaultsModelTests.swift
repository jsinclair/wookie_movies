//
//  UserDefaultsModelTests.swift
//  Wookie MoviesTests
//
//  Created by James Sinclair on 2021/11/19.
//

import XCTest
@testable import Wookie_Movies

class UserDefaultsModelTests: XCTestCase {

    public enum MovieDecodeError: String, LocalizedError {
        case failure = "Failed to decode movie JSON."

        public var errorDescription: String? { self.rawValue }
    }

    // swiftlint:disable line_length
    let movieJSON = """
    {
        "backdrop": "https://wookie.codesubmit.io/static/backdrops/d6822b7b-48bb-4b78-ad5e-9ba04c517ec8.jpg",
        "cast": [
            "Christian Bale",
            "Heath Ledger",
            "Aaron Eckhart"
        ],
        "classification": "13+",
        "director": "Christopher Nolan",
        "genres": [
            "Action",
            "Crime",
            "Drama"
        ],
        "id": "d6822b7b-48bb-4b78-ad5e-9ba04c517ec8",
        "imdb_rating": 9.0,
        "length": "2h 32min",
        "overview": "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.",
        "poster": "https://wookie.codesubmit.io/static/posters/d6822b7b-48bb-4b78-ad5e-9ba04c517ec8.jpg",
        "released_on": "2008-07-16T00:00:00",
        "slug": "the-dark-knight-2008",
        "title": "The Dark Knight"
    }
"""
    // swiftlint:disable line_length
    let movieJSON2 = """
    {
        "backdrop": "https://wookie.codesubmit.io/static/backdrops/d6822b7b-48bb-4b78-ad5e-9ba04c517ec8.jpg",
        "cast": [
            "Christian Bale",
            "Heath Ledger",
            "Aaron Eckhart"
        ],
        "classification": "13+",
        "director": "Christopher Nolan",
        "genres": [
            "Action",
            "Crime",
            "Drama"
        ],
        "id": "d6822b7b-48bb-4b78-ad5e-9ba04c517ec7",
        "imdb_rating": 9.0,
        "length": "2h 32min",
        "overview": "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.",
        "poster": "https://wookie.codesubmit.io/static/posters/d6822b7b-48bb-4b78-ad5e-9ba04c517ec8.jpg",
        "released_on": "2008-07-16T00:00:00",
        "slug": "the-dark-knight-2008",
        "title": "The Dark Knight"
    }
"""

    lazy var testMovie: Movie? = {
        return try? JSONDecoder().decode(Movie.self, from: movieJSON.data(using: .utf8)!)
    }()
    lazy var testMovie2: Movie? = {
        return try? JSONDecoder().decode(Movie.self, from: movieJSON2.data(using: .utf8)!)
    }()

    override func setUpWithError() throws {
        guard testMovie != nil, testMovie2 != nil else {
            throw MovieDecodeError.failure
        }

        // Clear movies for each fech
        for movie in UserDefaultsModel.getInstance().movies(for: .favourite) {
            UserDefaultsModel.getInstance().remove(movie: movie, for: .favourite)
        }
        for movie in UserDefaultsModel.getInstance().movies(for: .watched) {
            UserDefaultsModel.getInstance().remove(movie: movie, for: .watched)
        }
    }

    func testAddMovie() {
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 0)

        UserDefaultsModel.getInstance().add(movie: testMovie!, for: .favourite)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 1)
    }

    func testAddDuplicateMovie() {
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 0)

        UserDefaultsModel.getInstance().add(movie: testMovie!, for: .favourite)
        UserDefaultsModel.getInstance().add(movie: testMovie!, for: .favourite)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 1)
    }

    func testAdd2Movies() {
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 0)

        UserDefaultsModel.getInstance().add(movie: testMovie!, for: .favourite)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 1)

        UserDefaultsModel.getInstance().add(movie: testMovie2!, for: .favourite)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 2)
    }

    func testAddMoviesToDifferentGroups() {
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 0)
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .watched).count, 0)

        UserDefaultsModel.getInstance().add(movie: testMovie!, for: .favourite)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 1)
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .watched).count, 0)

        UserDefaultsModel.getInstance().add(movie: testMovie!, for: .watched)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 1)
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .watched).count, 1)

        UserDefaultsModel.getInstance().add(movie: testMovie2!, for: .watched)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 1)
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .watched).count, 2)

        UserDefaultsModel.getInstance().remove(movie: testMovie!, for: .favourite)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 0)
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .watched).count, 2)
    }

    func testRemoveMovie() {
        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 0)

        UserDefaultsModel.getInstance().add(movie: testMovie!, for: .favourite)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 1)

        UserDefaultsModel.getInstance().remove(movie: testMovie!, for: .favourite)

        XCTAssertEqual(UserDefaultsModel.getInstance().movies(for: .favourite).count, 0)
    }
}
