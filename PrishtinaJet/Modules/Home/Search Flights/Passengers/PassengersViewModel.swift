//
//  PassengersViewModel.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 25.6.21.
//

import UIKit

class PassengersViewModel {
    var model: SelectedFlightModel
    
    init(model: SelectedFlightModel) {
        self.model = model
    }
    
    var passengersCount: Int {
        return model.passengers.count
    }
    
    func update(passenger: Passenger, index: Int) {
        model.passengers[index] = passenger
    }
    
    func get(index: Int) -> Passenger {
        return model.passengers[index]
    }
}
