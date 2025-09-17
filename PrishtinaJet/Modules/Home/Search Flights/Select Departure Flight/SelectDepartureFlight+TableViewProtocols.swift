//
//  SelectDepartureFlight+Extensions.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 13.4.21.
//

import UIKit

extension SelectDepartureFlightViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.flightsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SearchFlightCell = tableView.dequeueReusableCell(for: indexPath) else {
            fatalError("Unregistered cell")
        }
        let flight = viewModel.flight(at: indexPath)
        let departure = viewModel.departure?.code
        let arrival = viewModel.arrival?.code
        cell.configure(with: flight, departureCode: departure, arrivalCode: arrival)
        cell.selectionStyle = .none
        return cell
    }
}

extension SelectDepartureFlightViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFlight = viewModel.flight(at: indexPath)
        continueButtonView.continueButton.isEnabled = true
    }
}

