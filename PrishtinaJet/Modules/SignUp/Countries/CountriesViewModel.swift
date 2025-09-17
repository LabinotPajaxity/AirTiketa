//
//  CountriesViewModel.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 27.5.21.
//

import UIKit

protocol CountriesViewModelDelegate: AnyObject {
    func didGetCountries()
    func didGetFailure()
}

class CountriesViewModel {
    var countries = [Country]()
    
    weak var delegate: CountriesViewModelDelegate?
    
    var countriesCount: Int {
        return countries.count
    }
    
    func getCountries() {
        GetCountries().perform { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                self?.delegate?.didGetCountries()
            case .failure(let error):
                print(error)
                self?.delegate?.didGetFailure()
            }
        }
    }
    
    func country(at index: Int) -> Country {
        return countries[index]
    }
}
