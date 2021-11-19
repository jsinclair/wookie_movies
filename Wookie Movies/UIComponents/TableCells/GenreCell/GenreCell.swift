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
    private let contentSubView = UIView()
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

        self.backgroundColor = .clear
        contentView.backgroundColor = .clear

        setupContentSubView()
        setupGenreLabel()
        setupScrollViewContainer()
        setupScrollView()
        setupMoviesStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentSubView() {
        contentView.addSubview(contentSubView)

        contentSubView.translatesAutoresizingMaskIntoConstraints = false

        contentSubView.backgroundColor = Theme.tableCellBackground
        contentSubView.layer.cornerRadius = 5.0

        NSLayoutConstraint.activate([
            contentSubView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            contentSubView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            contentSubView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            contentSubView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupGenreLabel() {
        contentSubView.addSubview(genreLabel)

        genreLabel.translatesAutoresizingMaskIntoConstraints = false

        genreLabel.font = genreLabel.font.withSize(24.0)
        genreLabel.textColor = .black

        NSLayoutConstraint.activate([
            genreLabel.leadingAnchor.constraint(equalTo: contentSubView.leadingAnchor, constant: padding),
            genreLabel.trailingAnchor.constraint(equalTo: contentSubView.trailingAnchor, constant: padding),
            genreLabel.topAnchor.constraint(equalTo: contentSubView.topAnchor, constant: padding)
        ])
    }

    private func setupScrollViewContainer() {
        contentSubView.addSubview(scrollViewContainer)

        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollViewContainer.leadingAnchor.constraint(equalTo: contentSubView.leadingAnchor, constant: padding),
            scrollViewContainer.trailingAnchor.constraint(equalTo: contentSubView.trailingAnchor, constant: -padding),
            scrollViewContainer.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: padding),
            scrollViewContainer.bottomAnchor.constraint(equalTo: contentSubView.bottomAnchor, constant: -padding),
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
