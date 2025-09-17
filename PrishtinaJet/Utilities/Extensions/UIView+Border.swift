//
//  UIView+Border.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/28/21.
//

import Foundation
import UIKit
import PureLayout

extension UIView {
    func addTopBorder(color: UIColor = .systemGray6, width: CGFloat = 1) {
        addBorder(color: color, width: width, edge: .top)
    }
    
    func addBottomBorder(color: UIColor = .systemGray6, width: CGFloat = 1) {
        addBorder(color: color, width: width, edge: .bottom)
    }
    
    func addLeftBorder(color: UIColor = .systemGray6, width: CGFloat = 1) {
        addBorder(color: color, width: width, edge: .leading)
    }
    
    func addRightBorder(color: UIColor = .systemGray6, width: CGFloat = 1) {
        addBorder(color: color, width: width, edge: .trailing)
    }

    private func addBorder(color: UIColor, width: CGFloat, edge: ALEdge) {
        let borderView = UIView()
        self.addSubview(borderView)
        borderView.backgroundColor = color
        
        if edge == .top {
            borderView.autoSetDimension(.height, toSize: width)
            borderView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        }
        else if edge == .bottom {
            borderView.autoSetDimension(.height, toSize: width)
            borderView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        }
        else if edge == .leading {
            borderView.autoSetDimension(.width, toSize: width)
            borderView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .trailing)
        }
        else if edge == .trailing {
            borderView.autoSetDimension(.width, toSize: width)
            borderView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .leading)
        }
    }
}
