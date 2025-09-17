//
//  PassengerSelectionType.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 3/31/21.
//

import Foundation

enum PassengerSelectionType: String, CaseIterable {
    case adult
    case child
    case inf
    
    var iconName: String {
        return self.rawValue
    }
    
    var title: String {
        return self.rawValue.capitalized.uppercased()
    }
        
    var subtitle: String {
        switch self {
        case .adult:
            return "14+ years"
        case .child:
            return "2-14 years"
        case .inf:
            return "0-2 years"
        }
    }
    
    var minimumValue: Int {
        switch self {
        case .adult:
            return 1
        default:
            return 0
        }
    }
    
    var maximumValue: Int {
//        switch self {
//        case .baby:
//            return 1
//        default:
//            return 10
//        }
        
        switch self {
        case .adult :
            return  10
        case .child:
            return 1
        case .inf:
            return 10
        }
    }
}
