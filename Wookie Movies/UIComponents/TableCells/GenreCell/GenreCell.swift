//
//  GenreCell.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/10.
//

import UIKit

class GenreCell: UITableViewCell {

    private let padding = CGFloat(8)
    private let imageHeight = CGFloat(120)

    /* UI Components */
    let genreLabel = UILabel()
    private let scrollViewContainer = UIView()
    private let scrollView = UIScrollView()
    let moviesStackView = UIStackView()

    /* View Model */
    var viewModel: GenreCellViewModel? {
        didSet {
            viewModel?.configure(cell: self)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupGenreLabel()
        setupScrollViewContainer()
        setupScrollView()
        setupMoviesStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGenreLabel() {
        contentView.addSubview(genreLabel)

        genreLabel.translatesAutoresizingMaskIntoConstraints = false

        genreLabel.font = genreLabel.font.withSize(24.0)
        genreLabel.textColor = .black

        NSLayoutConstraint.activate([
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding)
        ])
    }

    private func setupScrollViewContainer() {
        contentView.addSubview(scrollViewContainer)

        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            scrollViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            scrollViewContainer.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: padding),
            scrollViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            moviesStackView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
    }

    private func setupScrollView() {
        scrollViewContainer.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor)
        ])
    }

    private func setupMoviesStackView() {
        scrollView.addSubview(moviesStackView)

        moviesStackView.translatesAutoresizingMaskIntoConstraints = false
        moviesStackView.alignment = .fill
        moviesStackView.spacing = padding
        moviesStackView.axis = .horizontal

        NSLayoutConstraint.activate([
            moviesStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            moviesStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            moviesStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            moviesStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            moviesStackView.heightAnchor.constraint(equalTo: scrollViewContainer.heightAnchor)
        ])
    }
}
