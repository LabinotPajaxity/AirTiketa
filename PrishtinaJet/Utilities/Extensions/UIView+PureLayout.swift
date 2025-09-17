//
//  UIView+PureLayout.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/28/21.
//

import Foundation
import UIKit

extension UIView {
    func autoPinBelow(view: UIView, top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        autoPinEdge(toSuperviewEdge: .leading, withInset: left)
        autoPinEdge(toSuperviewEdge: .trailing, withInset: right)
        autoPinEdge(.top, to: .bottom, of: view, withOffset: top)
    }
    
    func autoPinEdgesSuperViewAndBelow(view: UIView, left: CGFloat = 0, right: CGFloat = 0) {
        autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        autoPinEdge(.top, to: .bottom, of: view)
    }
    
    func autoPinSidesSuperView(with inset: CGFloat = 0) {
        autoPinEdge(toSuperviewEdge: .leading, withInset: inset)
        autoPinEdge(toSuperviewEdge: .trailing, withInset: inset)
    }
}
