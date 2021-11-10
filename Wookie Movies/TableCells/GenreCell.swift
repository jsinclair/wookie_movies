//
//  GenreCell.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/10.
//

import UIKit

class GenreCell: UITableViewCell {

    private let padding = CGFloat(8)

    /* UI Components */
    let genreLabel = UILabel()
    let moviesTableView = UITableView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupGenreLabel()
        setupMoviesTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGenreLabel() {
        contentView.addSubview(genreLabel)

        genreLabel.translatesAutoresizingMaskIntoConstraints = false

        genreLabel.textColor = .black

        genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding).isActive = true
        genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
    }

    private func setupMoviesTableView() {
        contentView.addSubview(moviesTableView)

        moviesTableView.translatesAutoresizingMaskIntoConstraints = false

        moviesTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        moviesTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                  constant: padding).isActive = true
        moviesTableView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: padding).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: padding).isActive = true
    }
}
