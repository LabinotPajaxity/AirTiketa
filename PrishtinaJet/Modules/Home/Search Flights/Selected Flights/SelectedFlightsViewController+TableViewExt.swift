//
//  SelectedFlightsViewController+TableViewExt.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 13.7.21.
//

import UIKit

extension SelectedFlightsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if  selectedFlight.dateOfArrival != nil || selectedFlight.returnFlight != nil {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: SelectedFlightsCell = tableView.dequeueReusableCell(for: indexPath) else {
                fatalError("Unregister cell")
            }
            
            let flightInfo = FlightInfo(
                                flight: selectedFlight.departureFlight,
                                departureAirport: selectedFlight.departureAirport,
                                arrivalAirport: selectedFlight.arrivalAirport
                            )
            
            cell.configure(with: flightInfo)
            return cell
        case 1:
            if let flight = selectedFlight.returnFlight,
               let departureAirport = selectedFlight.returnDepartureAirport,
               let arrivalAirport = selectedFlight.returnArrivalAirport {
                
                guard let cell: SelectedFlightsCell = tableView.dequeueReusableCell(for: indexPath) else {
                    fatalError("Unregister cell")
                }
                let flightInfo = FlightInfo(flight: flight, departureAirport: departureAirport, arrivalAirport: arrivalAirport)
                
                cell.configureForReturnFlight(with: flightInfo)
                return cell
                
            } else {
                guard let cell: EmptyReturnFlightCell = tableView.dequeueReusableCell(for: indexPath) else {
                    fatalError("Unregister cell")
                }
                cell.delegate = self
                return cell
            }
        default:
            fatalError("Index out of range")
        }
    }
}

extension SelectedFlightsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return makeTitleView(with: selectedFlight.dateOfDeparture, isDeparture: true)
        case 1:
            if let date = selectedFlight.dateOfArrival {
                return makeTitleView(with: date, isDeparture: false)
            }
            return nil
        default:
            return nil
        }
    }
}
