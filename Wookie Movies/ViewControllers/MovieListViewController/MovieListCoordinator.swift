//
//  MovieListCoordinator.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import UIKit

class MovieListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let movieListViewController = MovieListViewController()
        let movieListViewModel = MovieListViewModel()
        movieListViewModel.delegate = movieListViewController
        movieListViewController.viewModel = movieListViewModel
        movieListViewController.coordinator = self
        navigationController.pushViewController(movieListViewController, animated: false)
    }
}
