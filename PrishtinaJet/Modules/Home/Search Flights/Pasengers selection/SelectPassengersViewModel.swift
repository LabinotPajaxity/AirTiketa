//
//  SelectPassengersViewModel.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 3/31/21.
//

import Foundation

class SelectPassengersViewModel {
    let inputView: HomeFormEntryView
    let model: SearchFlightModel
    
    init(model: SearchFlightModel, inputView: HomeFormEntryView) {
        self.inputView = inputView
        self.model = model
    }
}
