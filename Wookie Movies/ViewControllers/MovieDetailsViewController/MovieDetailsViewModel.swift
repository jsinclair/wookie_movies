//
//  MovieDetailsViewModel.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/14.
//

import Foundation
import UIKit

class MovieDetailsViewModel {
    let movie: Movie
    let dateFormatter: DateFormatter

    lazy var userDefaultsModel = UserDefaultsModel.getInstance()

    init(movie: Movie) {
        self.movie = movie
        self.dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }

    var backdropPath: String {
        movie.backdrop
    }

    var posterPath: String {
        movie.poster
    }

    var titleString: String {
        "\(movie.title) (\(movie.classification))"
    }

    var infoString: String {
        // Build the date and extract the year
        let date = dateFormatter.date(from: movie.releasedOn)
        let year = Calendar.current.dateComponents([.year], from: date ?? Date()).year

        // Build the director string
        var directorString = ""
        for director in movie.directors {
            if directorString.count > 0 {
                directorString.append(", ")
            }
            directorString.append(director)
        }

        return "\(year ?? 0) | \(movie.length) | \(directorString)"
    }

    var castString: String {
        var castString = "Cast: "
        for castMember in movie.cast {
            if castString.count > 6 {
                castString.append(", ")
            }
            castString.append(castMember)
        }

        return castString
    }

    var overviewString: String {
        movie.overview
    }

    var rating: Int {
        Int(movie.imdbRating / 2)
    }

    var favouriteButtonIsSelected: Bool {
        return movieSaved(for: .favourite)
    }

    var watchedButtonIsSelected: Bool {
        return movieSaved(for: .watched)
    }

    func favouriteTapped() -> Bool {
        return addOrRemoveMovie(for: .favourite)
    }

    func watchedTapped() -> Bool {
        return addOrRemoveMovie(for: .watched)
    }

    private func addOrRemoveMovie(for key: UserDefaultsKeys) -> Bool {
        if movieSaved(for: key) {
            userDefaultsModel.remove(movie: movie, for: key)
            return false
        } else {
            userDefaultsModel.add(movie: movie, for: key)
            return true
        }
    }

    private func movieSaved(for key: UserDefaultsKeys) -> Bool {
        return userDefaultsModel.movies(for: key).contains(where: { $0.id == movie.id })
    }
}
