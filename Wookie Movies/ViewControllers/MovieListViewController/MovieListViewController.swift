//
//  MovieListViewController.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import UIKit

class MovieListViewController: UIViewController {

    /* UI Components */
    let tableView = UITableView()
    let tabBar = UITabBar()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadMovies), for: .valueChanged)
        return refreshControl
    }()

    /* View model */
    var viewModel: MovieListViewModel?

    /* Coordinator */
    weak var coordinator: MovieListCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "WOOKIE MOVIES"

        view.backgroundColor = .white

        // UI Setup
        setupTabBar()
        setupTableView()

        // Load initial movies
        loadMovies()
    }

    func setupTabBar() {
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)

        tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tabBar.items = [
            UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0),
            UITabBarItem(tabBarSystemItem: .search, tag: 1)
        ]
    }

    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GenreCell.self, forCellReuseIdentifier: GenreCell.identifier())
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
    }

    @objc func loadMovies() {
        // Display the refresh control
        tableView.refreshControl = refreshControl
        refreshControl.beginRefreshing()
        viewModel?.loadMovies()
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreCell.identifier()) as? GenreCell else {
            return UITableViewCell()
        }

        cell.viewModel = viewModel?.genre(at: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.genreCount() ?? 0
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    func moviesLoaded() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }

    func loadErrorOccurred(error description: String) {
        let alert = UIAlertController(title: "Load Error",
                                      message: description,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry",
                                      style: .default,
                                      handler: { _ in
                                        self.loadMovies()
                                      }))
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.present(alert, animated: true, completion: nil)
        }
    }
}
