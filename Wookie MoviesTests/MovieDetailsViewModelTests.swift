//
//  MovieDetailsViewModelTests.swift
//  Wookie MoviesTests
//
//  Created by James Sinclair on 2021/11/14.
//

import XCTest
@testable import Wookie_Movies

class MovieDetailsViewModelTests: XCTestCase {

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

    lazy var testMovie: Movie? = {
        return try? JSONDecoder().decode(Movie.self, from: movieJSON.data(using: .utf8)!)
    }()
    var viewModel: MovieDetailsViewModel!

    override func setUpWithError() throws {
        guard let movie = testMovie else {
            throw MovieDecodeError.failure
        }
        viewModel = MovieDetailsViewModel(movie: movie)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testBackdropPath() {
        XCTAssertEqual(viewModel.backdropPath, testMovie?.backdrop)
    }

    func testPosterPath() {
        XCTAssertEqual(viewModel.posterPath, testMovie?.poster)
    }

    func testTitleString() {
        let titleString = "\(testMovie?.title ?? "") (\(testMovie?.classification ?? ""))"
        XCTAssertEqual(viewModel.titleString, titleString)
    }

    func testInfoString() {
        // Build the date and extract the year
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: testMovie?.releasedOn ?? "")
        let year = Calendar.current.dateComponents([.year], from: date ?? Date()).year

        // Build the director string
        var directorString = ""
        for director in testMovie?.directors ?? [] {
            if directorString.count > 0 {
                directorString.append(", ")
            }
            directorString.append(director)
        }

        let infoString = "\(year ?? 0) | \(testMovie?.length ?? "") | \(directorString)"
        XCTAssertEqual(viewModel.infoString, infoString)
    }

    func testCastString() {
        var castString = "Cast: "
        for castMember in testMovie?.cast ?? [] {
            if castString.count > 6 {
                castString.append(", ")
            }
            castString.append(castMember)
        }

        XCTAssertEqual(viewModel.castString, castString)
    }

    func testOverviewString() {
        XCTAssertEqual(viewModel.overviewString, testMovie?.overview)
    }
}
