//
//  MovieTapGestureRecognizer.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/14.
//

import UIKit

class MovieTapGestureRecognizer: UITapGestureRecognizer {
    let movie: Movie

    init(movie: Movie, target: Any?, action: Selector?) {
        self.movie = movie

        super.init(target: target, action: action)
    }
}
