//
//  SelectAirportViewModel.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/2/21.
//

import Foundation

protocol SelectAirportViewModelDelegate: AnyObject {
    func didFetchCountries()
    func didFailToFetchCountries(with errorMessage: String)
}

class SelectAirportViewModel {
    private var countries = [Country]()
    var isLoading = false
    
    weak var delegate: SelectAirportViewModelDelegate?
    
    var countriesCount: Int {
        return countries.count
    }
    
    let inputView: HomeFormEntryView
    let searchFlightModel: SearchFlightModel
    
    init(inputView: HomeFormEntryView, searchFlightModel: SearchFlightModel) {
        self.inputView = inputView
        self.searchFlightModel = searchFlightModel
    }
    
    func getAirports() {
        if isLoading {
            return
        }
        isLoading = true
        
        GetAirports(departureAirportId: searchFlightModel.departureAirportId).perform { result in
            self.isLoading = false
            
            switch result {
            case .success(let countries):
                self.countries = countries
                self.delegate?.didFetchCountries()
            case .failure(let error):
                self.delegate?.didFailToFetchCountries(with: error.localizedDescription)
            }
        }
    }
    
    func select(airport: Airport) {
        inputView.value = airport.name
        if inputView.model == .from {
            searchFlightModel.departureAirportId = airport.id
            searchFlightModel.departureAirportName = airport.name
            searchFlightModel.arrivalAirportId = nil
            searchFlightModel.arrivalAirportName = nil
        } else {
            searchFlightModel.arrivalAirportId = airport.id
            searchFlightModel.arrivalAirportName = airport.name
        }
    }
    
    func country(at index: Int) -> Country {
        return countries[index]
    }
    
    func airport(at indexPath: IndexPath) -> Airport {
        return countries[indexPath.section].airports[indexPath.row]
    }
    
}
