//
//  DataSource.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/19.
//

import Foundation

protocol DataSourceDelegate: AnyObject {
    func loaded(movies: [Movie], with error: String?)
}

protocol DataSource {
    var delegate: DataSourceDelegate? {get set}

    func loadMovies(searchParam: String?)
}
