//
//  MovieListViewModelTests.swift
//  Wookie MoviesTests
//
//  Created by James Sinclair on 2021/11/09.
//

import XCTest
@testable import Wookie_Movies

class MovieListViewModelTests: XCTestCase {

    var viewModel: MovieListViewModel?

    override func setUpWithError() throws {
        viewModel = MovieListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testLoadAllMovies() {
        guard let viewModel = viewModel else {
            XCTFail("The view model was not initialised.")
            return
        }

        let testDelegate = LoadMoviesTestDelegate(expectation: self.expectation(description: "LoadAllMovies"))
        viewModel.delegate = testDelegate

        viewModel.loadMovies()
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertGreaterThan(viewModel.genreCount(), 0)
        for index in 0..<viewModel.genreCount() {
            XCTAssertGreaterThan(viewModel.genre(at: index)?.movies.count ?? 0, 0)
        }
    }

    func testLoadMoviesWithSearchParam() {
        guard let viewModel = viewModel else {
            XCTFail("The view model was not initialised.")
            return
        }

        let testDelegate = LoadMoviesTestDelegate(
            expectation: self.expectation(description: "LoadMoviesWithSearchParam"))
        viewModel.delegate = testDelegate

        viewModel.loadMovies(searchParam: "Crime")
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertGreaterThan(viewModel.genreCount(), 0)
        for index in 0..<viewModel.genreCount() {
            XCTAssertGreaterThan(viewModel.genre(at: index)?.movies.count ?? 0, 0)
        }
    }

    class LoadMoviesTestDelegate: MovieListViewModelDelegate {
        let expectation: XCTestExpectation

        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }

        func moviesLoaded() {
            expectation.fulfill()
        }

        func loadErrorOccurred(error description: String) {

        }
    }
}
