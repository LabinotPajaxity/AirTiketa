//
//  CountriesViewController+UISearchController.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 27.5.21.
//

import UIKit

extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchArray.removeAll(keepingCapacity: false)
        
        guard let keyword = searchController.searchBar.text,
              !keyword.isEmpty else {
                    searchArray = viewModel.countries
                    tableView.reloadData()
                    return
        }
        searchArray = viewModel.countries.filter { country -> Bool in
            country.name.lowercased().contains(keyword.lowercased())
        }
        tableView.reloadData()
    }
}

extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
    }
}

