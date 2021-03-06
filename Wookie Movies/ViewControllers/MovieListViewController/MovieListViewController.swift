//
//  MovieListViewController.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import UIKit

class MovieListViewController: UIViewController {

    enum Tabs: Int {
        case home, favourites, watched
    }

    /* Layout */
    private let padding = CGFloat(8)

    /* UI Components */
    let homeImage = UIImage(named: "home")
    let glassesImage = UIImage(named: "glasses")
    let favouritesImage = UIImage(systemName: "heart")
    let tableView = UITableView()
    let tabBar = UITabBar()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
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

        view.backgroundColor = Theme.viewControllerBackground

        // UI Setup
        setupSearchButton()
        setupTabBar()
        setupTableView()

        // Load initial movies
        loadMovies()
    }

    private func setupSearchButton() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(presetSearchAlert))
        ]
    }

    private func setupTabBar() {
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)

        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        tabBar.items = [
            UITabBarItem(title: "Home", image: homeImage, tag: Tabs.home.rawValue),
            UITabBarItem(title: "Favourites", image: favouritesImage, tag: Tabs.favourites.rawValue),
            UITabBarItem(title: "Watched", image: glassesImage, tag: Tabs.watched.rawValue)
        ]

        tabBar.selectedItem = tabBar.items![0]
        tabBar.delegate = self
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GenreCell.self, forCellReuseIdentifier: GenreCell.identifier())
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = .clear
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
    }

    @objc func refresh() {
        loadMovies()
    }

    func loadMovies(searchParam: String? = nil) {
        // Display the refresh control
        refreshControl.beginRefreshing()
        viewModel?.loadMovies(for: tabBar.selectedItem?.tag ?? 0, with: searchParam)
    }

    @objc func presetSearchAlert() {
        let alert = UIAlertController(title: "What are you looking for?", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?[0].placeholder = "Enter your search term in here!"

        let submitAction = UIAlertAction(title: "Search", style: .default) { [unowned alert] _ in
            self.loadMovies(searchParam: alert.textFields![0].text)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(submitAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}

extension MovieListViewController: GenreCellViewModelDelegate {
    func movieTapped(_ movie: Movie) {
        coordinator?.presentMovieDetails(movie)
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let viewModel = viewModel else { return UITableViewCell() }

        if viewModel.genreCount() == 0 {
            let cell = UITableViewCell()
            cell.contentView.backgroundColor = Theme.tableCellBackground
            cell.textLabel?.text = viewModel.emptyListLabelString
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreCell.identifier()) as? GenreCell else {
                return UITableViewCell()
            }

            let cellViewModel = viewModel.genre(at: indexPath.row)
            cellViewModel?.delegate = self
            cell.viewModel = cellViewModel
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.genreCount() == 0 ? 1 : viewModel.genreCount()
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    func moviesLoaded() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0),
                                       at: .top,
                                       animated: true)
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

extension MovieListViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        loadMovies()
    }
}
