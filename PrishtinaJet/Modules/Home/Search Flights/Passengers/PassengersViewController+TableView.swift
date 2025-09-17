//
//  PassengersViewController+Extensions.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 15.4.21.
//

import UIKit

extension PassengersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.passengersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PassengersCell = tableView.dequeueReusableCell(for: indexPath) else {
            fatalError("Unregistered cell")
        }
        let passenger = viewModel.get(index: indexPath.row)
        cell.configureForBookingDetails(passenger: passenger, index: indexPath.row + 1)
        return cell
    }
}

extension PassengersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passengerIndexRow = indexPath.row
        let passenger = viewModel.get(index: passengerIndexRow)
        let passengersInformationVC = PassengersInformationViewController(passenger: passenger)
        passengersInformationVC.delegate = self
        navigationController?.pushViewController(passengersInformationVC, animated: true)
    }
}

extension PassengersViewController: PassengersInformationControllerDelegate {
    func didCompletePassengerInfo(_ passenger: Passenger) {
        viewModel.update(passenger: passenger, index: passengerIndexRow)
        tableView.reloadData()
    }
}
