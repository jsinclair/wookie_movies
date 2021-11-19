//
//  APIModel.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import Foundation

class APIModel {

    internal static let baseURL = "https://wookie.codesubmit.io/movies"

    static let bearerToken = "Bearer Wookie2019"

    private init() {

    }

    static func buildURL(with searchParam: String? = nil) -> URL? {
        guard var url = URLComponents(string: baseURL) else {
            return nil
        }

        if let searchParam = searchParam, searchParam.count > 0 {
            url.queryItems = [
                URLQueryItem(name: "q", value: searchParam)
            ]
        }

        return url.url
    }
}
