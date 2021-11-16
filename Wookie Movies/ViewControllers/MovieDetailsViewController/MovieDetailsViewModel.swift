//
//  MovieDetailsViewModel.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/14.
//

import Foundation

class MovieDetailsViewModel {
    let movie: Movie
    let dateFormatter: DateFormatter

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
}
