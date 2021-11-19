//
//  LocalDataSource.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/19.
//

import Foundation

class LocalDataSource: DataSource {

    let userDefualtsListKey: UserDefaultsKeys

    private weak var dataSourceDelegate: DataSourceDelegate?

    var delegate: DataSourceDelegate? {
        get {
            dataSourceDelegate
        }
        set {
            dataSourceDelegate = newValue
        }
    }

    private lazy var userDefaultsModel = UserDefaultsModel.getInstance()

    init(userDefualtsListKey: UserDefaultsKeys) {
        self.userDefualtsListKey = userDefualtsListKey
    }

    func loadMovies(searchParam: String?) {
        var movies = userDefaultsModel.movies(for: userDefualtsListKey)

        if let searchParam = searchParam,
           searchParam.trimmingCharacters(in: .whitespaces).count > 0 {

            movies = movies.filter({ $0.overview.contains(searchParam) })
        }

        delegate?.loaded(movies: movies, with: nil)
    }
}
