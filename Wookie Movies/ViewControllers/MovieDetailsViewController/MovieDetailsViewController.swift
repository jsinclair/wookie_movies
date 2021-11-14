//
//  MovieDetailsViewController.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/14.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    /* Layout Constants */
    let bigPadding: CGFloat = 16
    let smallPadding: CGFloat = 8
    let imageHeight: CGFloat = 120

    /* Coordinator */
    var coordinator: MovieDetailsCoordinator?

    /* View Model */
    var viewModel: MovieDetailsViewModel?

    /* UI Components */
    let scrollView = UIScrollView()
    let contentView = UIView()
    let backdropImageView = UIImageView()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let infoLabel = UILabel()
    let castLabel = UILabel()
    let overviewLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Movie Details"

        view.backgroundColor = Theme.viewControllerBackground

        // Configure UI Componentes
        configureScrollView()
        configureContentView()
        configureBackdropImageView()
        configurePosterImageView()
        configureTitleLabel()
        configureInfoLabel()
        configureCastLabel()
        configureOverviewLabel()

    }

    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    private func configureBackdropImageView() {
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backdropImageView)

        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.widthAnchor.constraint(equalTo: backdropImageView.heightAnchor,
                                                     multiplier: 1920.0/1080.0)
        ])

        if let backdropPath = viewModel?.backdropPath {
            backdropImageView.downloaded(from: backdropPath)
        }
    }

    private func configurePosterImageView() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImageView)

        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: bigPadding),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor,
                                                   multiplier: 342.0/513.0),
            posterImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            posterImageView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: imageHeight / 2)
        ])

        if let posterPath = viewModel?.posterPath {
            posterImageView.downloaded(from: posterPath)
        }
    }

    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = .white

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -smallPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -smallPadding),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: smallPadding)
        ])

        titleLabel.text = viewModel?.titleString
    }

    private func configureInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoLabel)
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping

        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: smallPadding),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -bigPadding),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: bigPadding)
        ])

        infoLabel.text = viewModel?.infoString
    }

    private func configureCastLabel() {
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(castLabel)
        castLabel.numberOfLines = 0
        castLabel.lineBreakMode = .byWordWrapping

        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: bigPadding),
            castLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -bigPadding),
            castLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: bigPadding)
        ])

        castLabel.text = viewModel?.castString
    }

    private func configureOverviewLabel() {
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overviewLabel)
        overviewLabel.numberOfLines = 0
        overviewLabel.lineBreakMode = .byWordWrapping

        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: bigPadding),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -bigPadding),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: bigPadding),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bigPadding)
        ])

        overviewLabel.text = viewModel?.overviewString
    }

}