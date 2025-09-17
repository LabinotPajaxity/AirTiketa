//
//  UITableView+RegisterCell.swift
//  RxSwiftDemo
//
//  Created by Blerd Foniqi on 4/13/20.
//  Copyright © 2020 Blerd Foniqi. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register(cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
    
    func register(headerFooterView: AnyClass) {
        register(headerFooterView, forHeaderFooterViewReuseIdentifier: String(describing: headerFooterView))
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T
    }
}

extension UICollectionView {
    func register(cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
    }
}
