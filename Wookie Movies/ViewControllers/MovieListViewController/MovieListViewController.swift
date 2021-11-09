//
//  MovieListViewController.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import UIKit

class MovieListViewController: UIViewController {

    weak var coordinator: MovieListCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "WOOKIE MOVIES"

        view.backgroundColor = .white

        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie List View Controller"
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
