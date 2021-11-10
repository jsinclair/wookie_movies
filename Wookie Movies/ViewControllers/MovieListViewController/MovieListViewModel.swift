//
//  MovieListViewModel.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import Foundation

protocol MovieListViewModelDelegate: AnyObject {
    func moviesLoaded()

    func loadErrorOccurred(error description: String)
}

class MovieListViewModel {
    weak var delegate: MovieListViewModelDelegate?

    private var genres: [String: [Movie]] = [:]

    func loadMovies(searchParam: String? = nil) {
        guard let url = APIModel.buildURL(with: searchParam) else {
            delegate?.loadErrorOccurred(error: "Error building URL.")
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

    func genreCount() -> Int {
        genres.count
    }

    func genre(at index: Int) -> String? {
        guard index < genres.count, index >= 0 else {
            return nil
        }
        return genres.keys.sorted()[index]
    }

    func movies(for genre: String) -> Int? {
        genres[genre]?.count
    }

    func movie(for genre: String, at index: Int) -> Movie? {
        genres[genre]?[index]
    }

    private func handleLoadMoviesResult(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            delegate?.loadErrorOccurred(error: error.localizedDescription)
        } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            delegate?.loadErrorOccurred(error: "Unexpected server respnse. Please try again.")
        } else {

            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data,
                                                            options: .allowFragments) as? [String: Any],
               let moviesJSON = json["movies"] as? [[String: Any]] {

                let decoder = JSONDecoder()
                if let encodedJSON = try? JSONSerialization.data(withJSONObject: moviesJSON,
                                                                 options: .prettyPrinted) {

                    do {
                        let movies = try decoder.decode([Movie].self, from: encodedJSON)
                        self.populateGenres(movies: movies)
                        delegate?.moviesLoaded()
                    } catch {
                        delegate?.loadErrorOccurred(error: "Invalid server respnse. Please try again.")
                    }
                } else {
                    delegate?.loadErrorOccurred(error: "Invalid server respnse. Please try again.")
                }
            } else {
                delegate?.loadErrorOccurred(error: "Invalid server respnse. Please try again.")
            }
        }
    }

    private func populateGenres(movies: [Movie]) {
        // clear current movies and genres
        genres.removeAll()

        for movie in movies {
            for genre in movie.genres {
                var currentMovies = genres[genre] ?? []
                currentMovies.append(movie)
                genres[genre] = currentMovies
            }
        }
    }
}
