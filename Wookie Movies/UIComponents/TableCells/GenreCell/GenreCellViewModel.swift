//
//  GenreCellViewModel.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/10.
//

import UIKit

protocol GenreCellViewModelDelegate: AnyObject {
    func movieTapped(_ movie: Movie)
}

class GenreCellViewModel: NSObject {
    private let genre: String
    internal let movies: [Movie]

    /* Delegate */
    weak var delegate: GenreCellViewModelDelegate?

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
        imageView.isUserInteractionEnabled = true

        imageView.addGestureRecognizer(MovieTapGestureRecognizer(movie: movie,
                                                                 target: self,
                                                                 action: #selector(movieTapped(sender:))))
    }

    @objc func movieTapped(sender: UIGestureRecognizer) {
        guard let sender = sender as? MovieTapGestureRecognizer else {
            return
        }

        delegate?.movieTapped(sender.movie)
    }
}
