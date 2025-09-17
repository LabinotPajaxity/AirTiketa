//
//  BoardingVC.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 22.10.21..
//

import UIKit

class BoardingVC: UIViewController {
    
    @IBOutlet weak var flightIcon: UIImageView!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var secondFlightIcon: UIImageView!
    @IBOutlet weak var viewRetunFlight: UIView!
    
    @IBOutlet weak var directionLocation: UILabel!
    @IBOutlet weak var toLocation: UILabel!
    @IBOutlet weak var nameUserNameOutlet: UILabel!
    @IBOutlet weak var surnameUserOutlet: UILabel!
    @IBOutlet weak var departureTimeOutlet: UILabel!
    @IBOutlet weak var dateDepartureOutlet: UILabel!
    @IBOutlet weak var arrivalTimeOutlet: UILabel!
    @IBOutlet weak var arrivalDateOutlet: UILabel!
    @IBOutlet weak var durationOutlet: UILabel!
    @IBOutlet weak var FlightNumber: UILabel!
    @IBOutlet weak var gateOutlet: UILabel!
    
    @IBOutlet weak var returnTicketdirectionLocation: UILabel!
    @IBOutlet weak var returnTickettoLocation: UILabel!
    @IBOutlet weak var returnTicketnameUserNameOutlet: UILabel!
    @IBOutlet weak var returnTicketsurnameUserOutlet: UILabel!
    @IBOutlet weak var returnTicketdepartureTimeOutlet: UILabel!
    @IBOutlet weak var returnTicketdateDepartureOutlet: UILabel!
    @IBOutlet weak var returnTicketarrivalTimeOutlet: UILabel!
    @IBOutlet weak var returnTicketarrivalDateOutlet: UILabel!
    @IBOutlet weak var returnTicketdurationOutlet: UILabel!
    @IBOutlet weak var returnTicketFlightNumber: UILabel!
    @IBOutlet weak var returnTicketgateOutlet: UILabel!

    // MARK: - Properties
       var boradingArray: TravelersDetail?
       
       // MARK: - Lifecycle
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           setupDataForBoardingScreen()
           setupFlightVisibility()
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
       }
       
       // MARK: - Setup Methods
       private func setupUI() {
           viewScroll.backgroundColor = AppColors.almostWhite
           
           // Tint icons red
           [flightIcon, secondFlightIcon].forEach {
               $0?.image = $0?.image?.withRenderingMode(.alwaysTemplate)
               $0?.tintColor = AppColors.newRedColorForALL
           }
           
           // Make labels auto-shrink if text is long
           [directionLocation,
            toLocation,
            returnTicketdirectionLocation,
            returnTickettoLocation].forEach {
               $0?.adjustsFontSizeToFitWidth = true
               $0?.minimumScaleFactor = 0.8
           }
       }
       
       private func setupFlightVisibility() {
           if boradingArray?.returningFlight == nil {
               viewRetunFlight.isHidden = true
               viewScroll.heightAnchor.constraint(equalToConstant: 600).isActive = true
           } else {
               viewRetunFlight.isHidden = false
               viewScroll.heightAnchor.constraint(equalToConstant: 1020).isActive = true
           }
       }
       
       private func setupDataForBoardingScreen() {
           guard let boarding = boradingArray else { return }
           
           // Departure
           directionLocation.text = boarding.departureFlight?.departureAirport
           toLocation.text = boarding.departureFlight?.arrivalAirport
           nameUserNameOutlet.text = boarding.name
           surnameUserOutlet.text = boarding.surname
           departureTimeOutlet.text = boarding.departureFlight?.timeOfDeparture
           dateDepartureOutlet.text = boarding.departureFlight?.dateOfDeparture
           arrivalTimeOutlet.text = boarding.departureFlight?.timeOfArrival
           arrivalDateOutlet.text = boarding.departureFlight?.dateOfDeparture
           durationOutlet.text = boarding.departureFlight?.duration
           FlightNumber.text = boarding.departureFlight?.flightNumber
           gateOutlet.text = boarding.departureFlight?.gate
           
           // Return
           returnTicketdirectionLocation.text = boarding.returningFlight?.departureAirport
           returnTickettoLocation.text = boarding.returningFlight?.arrivalAirport
           returnTicketnameUserNameOutlet.text = boarding.name
           returnTicketsurnameUserOutlet.text = boarding.surname
           returnTicketdepartureTimeOutlet.text = boarding.returningFlight?.timeOfDeparture
           returnTicketdateDepartureOutlet.text = boarding.returningFlight?.dateOfDeparture
           returnTicketarrivalTimeOutlet.text = boarding.returningFlight?.timeOfArrival
           returnTicketarrivalDateOutlet.text = boarding.returningFlight?.dateOfDeparture
           returnTicketdurationOutlet.text = boarding.returningFlight?.duration
           returnTicketFlightNumber.text = boarding.returningFlight?.flightNumber
           returnTicketgateOutlet.text = boarding.returningFlight?.gate
       }
}
