//
//  UITableViewCell+Identifier.swift
//  RxSwiftDemo
//
//  Created by Blerd Foniqi on 4/12/20.
//  Copyright © 2020 Blerd Foniqi. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
