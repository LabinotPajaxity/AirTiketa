//
//  InputViewType.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/27/21.
//

import Foundation
import UIKit

protocol InputViewType {
    var value: String? { get set }
}

extension InputViewType where Self: UIView {
    var value: String? {
        return self.value
    }
}
