//
//  Coordinator.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/09.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
