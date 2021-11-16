//
//  RatingView.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/16.
//

import UIKit

class RatingView: UIView {

    /* Images */
    let emptyStar = UIImage(named: "empty_star")
    let fullStar = UIImage(named: "full_star")

    /* UI Components */
    let starContainer = UIStackView()
    let star1 = UIImageView()
    let star2 = UIImageView()
    let star3 = UIImageView()
    let star4 = UIImageView()
    let star5 = UIImageView()
    private lazy var starViews = [
        star1,
        star2,
        star3,
        star4,
        star5
    ]

    required init() {
        super.init(frame: .zero)
        // Setting up the view can be done here
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        setupConstraints()

        resetRating()
    }

    func setupConstraints() {
        starContainer.translatesAutoresizingMaskIntoConstraints = false
        starContainer.axis = .horizontal
        starContainer.spacing = 4.0
        self.addSubview(starContainer)

        NSLayoutConstraint.activate([
            starContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            starContainer.topAnchor.constraint(equalTo: self.topAnchor),
            starContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            starContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        for starView in starViews {
            starView.contentMode = .scaleAspectFit
            starContainer.addArrangedSubview(starView)
        }
    }

    /* Sets the rating to 0 */
    func resetRating() {
        for starView in starViews {
            starView.image = emptyStar
        }
    }

    func set(rating: Int) {
        resetRating()
        for index in 0..<rating where index < starViews.count {
            starViews[index].image = fullStar
        }
    }
}
