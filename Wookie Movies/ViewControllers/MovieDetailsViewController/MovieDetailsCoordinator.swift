//
//  MovieDetailsCoordinator.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/14.
//

import UIKit

class MovieDetailsCoordinator: Coordinator {
    let movie: Movie
    var navigationController: UINavigationController

    init(movie: Movie, navigationController: UINavigationController) {
        self.movie = movie
        self.navigationController = navigationController
    }

    func start() {
        let movieDetailsViewController = MovieDetailsViewController()
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movie)
        movieDetailsViewController.viewModel = movieDetailsViewModel
        movieDetailsViewController.coordinator = self
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
