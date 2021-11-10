//
//  GenreCellViewModel.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/10.
//

import UIKit

class GenreCellViewModel: NSObject {
    private let genre: String
    private let movies: [Movie]

    init(genre: String, movies: [Movie]) {
        self.genre = genre
        self.movies = movies
    }

    func configure(cell: GenreCell) {
        cell.genreLabel.text = genre

        // populate stack view with images
        cell.moviesStackView.removeAllArrangedSubviews()
        for movie in movies {
            add(movie: movie, to: cell.moviesStackView)
        }
    }

    private func add(movie: Movie, to stackView: UIStackView) {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 513.0/342.0).isActive = true

        stackView.addArrangedSubview(imageView)

        imageView.downloaded(from: movie.poster)
    }
}
