//
//  APIModelTests.swift
//  Wookie MoviesTests
//
//  Created by James Sinclair on 2021/11/09.
//

import XCTest
@testable import Wookie_Movies

class APIModelTests: XCTestCase {
    func testURLWithoutSearchParam() {
        let url = APIModel.buildURL()

        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, APIModel.baseURL)
    }

    func testURLWithSearchParam() {
        let url = APIModel.buildURL(with: "Crime")

        guard let url = url else {
            XCTFail("The url was not initialised.")
            return
        }

        let urlComponents = URLComponents(string: url.absoluteString)

        XCTAssertNotNil(urlComponents)
        XCTAssertEqual(urlComponents?.queryItems?.count, 1)
        XCTAssertEqual(urlComponents?.queryItems?[0].name, "q")
        XCTAssertEqual(urlComponents?.queryItems?[0].value, "Crime")
    }
}
