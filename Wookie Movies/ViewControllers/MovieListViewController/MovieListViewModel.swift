//
//  MovieListViewModel.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import Foundation

protocol MovieListViewModelDelegate: AnyObject {
    func moviesLoaded()

    func loadErrorOccurred(error description: String)
}

class MovieListViewModel {
    weak var delegate: MovieListViewModelDelegate?

    private var genres: [String: [Movie]] = [:]

    private(set) var emptyListLabelString = "Loading movies..."

    /* Data sources */
    private lazy var webDataSource: WebDataSource = {
        let dataSource = WebDataSource()
        dataSource.delegate = self
        return dataSource
    }()
    private lazy var favouritesDataSource: LocalDataSource = {
        let dataSource = LocalDataSource(userDefualtsListKey: .favourite)
        dataSource.delegate = self
        return dataSource
    }()
    private lazy var watchedDataSource: LocalDataSource = {
        let dataSource = LocalDataSource(userDefualtsListKey: .watched)
        dataSource.delegate = self
        return dataSource
    }()

    private lazy var dataSources: [Int: DataSource] = [
        MovieListViewController.Tabs.home.rawValue: webDataSource,
        MovieListViewController.Tabs.favourites.rawValue: favouritesDataSource,
        MovieListViewController.Tabs.watched.rawValue: watchedDataSource
    ]

    func loadMovies(for tab: Int, with searchParam: String? = nil) {
        guard let dataSource = dataSources[tab] else {
            delegate?.loadErrorOccurred(error: "Invalid search type.")
            return
        }
        dataSource.loadMovies(searchParam: searchParam)
    }

    func genreCount() -> Int {
        genres.count
    }

    func genre(at index: Int) -> GenreCellViewModel? {
        guard index < genres.count,
              index >= 0 else {
            return nil
        }
        let genre = genres.keys.sorted()[index]
        return GenreCellViewModel(genre: genre, movies: genres[genre] ?? [])
    }

    private func populateGenres(movies: [Movie]) {
        // clear current movies and genres
        genres.removeAll()

        for movie in movies {
            for genre in movie.genres {
                var currentMovies = genres[genre] ?? []
                currentMovies.append(movie)
                genres[genre] = currentMovies
            }
        }
    }
}

extension MovieListViewModel: DataSourceDelegate {
    func loaded(movies: [Movie], with error: String?) {
        populateGenres(movies: movies)

        emptyListLabelString = "No movies found :("

        if let error = error {
            delegate?.loadErrorOccurred(error: error)
        } else {
            delegate?.moviesLoaded()
        }
    }
}
