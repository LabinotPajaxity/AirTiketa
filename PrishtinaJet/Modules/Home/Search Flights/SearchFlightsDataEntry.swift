//
//  HomeDataEntry.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/27/21.
//

import Foundation
import UIKit
import PureLayout

enum SearchFlightsDataEntry: String, CaseIterable {
    case from
    case to
    case departure
    case `return`
    case passengers
    
    var title: String {
        return self.rawValue.capitalized
    }
    
    var placeholder: String {
        switch self {
        case .departure, .return:
            return "dd/mm/yyyy"
        default:
            return "Choose"
        }
    }
    
    var placeholderFont: UIFont {
        switch self {
        case .departure, .return:
            return UIFont.systemFont(ofSize: 16)
        default:
            return UIFont.systemFont(ofSize: 20)
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .from, .to:
            return UIImage(named: "right-chevron")
        case .departure, .return:
            return UIImage(named: "calendar")
        case .passengers:
            return UIImage(named: "person")
        }
    }
    
    var height: CGFloat {
        switch self {
        case .departure, .return:
            return 65
        default:
            return 70
        }
    }
    
    static func makeDataEntries() -> [SearchFlightsDataEntry: HomeFormEntryView] {
        return Dictionary(uniqueKeysWithValues: self.allCases.map {
            ($0, HomeFormEntryView(model: $0))
        })
    }
}
