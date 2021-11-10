//
//  UITableViewCell+Extension.swift
//  Wookie Movies
//
//  Created by James Sinclair on 2021/11/10.
//

import UIKit

extension UITableViewCell {
    class func identifier() -> String {
        return String(describing: self)
    }
}
