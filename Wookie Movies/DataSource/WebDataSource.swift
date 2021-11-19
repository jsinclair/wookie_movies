//
//  WebDataSource.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/19.
//

import Foundation

class WebDataSource: DataSource {
    private weak var dataSourceDelegate: DataSourceDelegate?

    var delegate: DataSourceDelegate? {
        get {
            dataSourceDelegate
        }
        set {
            dataSourceDelegate = newValue
        }
    }

    func loadMovies(searchParam: String?) {
        guard let url = APIModel.buildURL(with: searchParam) else {
            delegate?.loaded(movies: [], with: "Error building URL.")
            return
        }

        var request = URLRequest(url: url)
        // request.httpMethod = "GET"
        request.setValue(APIModel.bearerToken, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            self.handleLoadMoviesResult(data: data, response: response, error: error)
        }

        task.resume()
    }

    private func handleLoadMoviesResult(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            delegate?.loaded(movies: [], with: error.localizedDescription)
        } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            delegate?.loaded(movies: [], with: "Unexpected server respnse. Please try again.")
        } else {

            var movies = [Movie]()
            var error: String? = "Invalid server respnse. Please try again."

            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data,
                                                            options: .allowFragments) as? [String: Any],
               let moviesJSON = json["movies"] as? [[String: Any]] {

                let decoder = JSONDecoder()
                if let encodedJSON = try? JSONSerialization.data(withJSONObject: moviesJSON,
                                                                 options: .prettyPrinted) {
                    movies = (try? decoder.decode([Movie].self, from: encodedJSON)) ?? []
                    error = nil
                }
            }

            delegate?.loaded(movies: movies, with: error)
        }
    }
}
