//
//  BoradingPassViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 18.10.21..
//

import UIKit

class BoradingPassViewController: UIViewController {

    @IBOutlet weak var viewScroll: UIView!
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
    @IBOutlet weak var iconFlight: UIImageView!
    @IBOutlet weak var secondIconFLight: UIImageView!
    
    var bookingArray: TravelersDetailModel?
    
    override func viewWillAppear(_ animated: Bool) {
        setupAllDataInLabel()
        
        if bookingArray?.returningFlight == nil {
            viewRetunFlight.isHidden = true
            viewScroll.heightAnchor.constraint(equalToConstant: 600).isActive = true
        } else {
            viewRetunFlight.isHidden = false
            viewScroll.heightAnchor.constraint(equalToConstant: 1020).isActive = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNagivation()
        setupUI()
    }
    private func setupAllDataInLabel() {
        guard let dateFormatForDeparture = bookingArray?.departureFlight?.dateOfDeparture else {return }
        let departureDate = formattedDateFromString(dateString: dateFormatForDeparture, withFormat: "E MMM, MM")
        guard let dateFormatForArrival = bookingArray?.departureFlight?.dateOfArrival else {return}
        let arrivalDate = formattedDateFromString(dateString: dateFormatForArrival, withFormat: "E MMM, MM")

        directionLocation.text = bookingArray?.departureFlight?.departureAirport
        toLocation.text = bookingArray?.departureFlight?.arrivalAirport
        nameUserNameOutlet.text = bookingArray?.name
        surnameUserOutlet.text = bookingArray?.surname
        departureTimeOutlet.text = bookingArray?.departureFlight?.timeOfDeparture
        dateDepartureOutlet.text = departureDate
        arrivalTimeOutlet.text = bookingArray?.departureFlight?.timeOfArrival
        arrivalDateOutlet.text = arrivalDate
        durationOutlet.text = bookingArray?.departureFlight?.duration
        FlightNumber.text = bookingArray?.departureFlight?.flightNumber
        gateOutlet.text = bookingArray?.departureFlight?.gate
        
        
        guard let dateFormatForReturnDeparture = bookingArray?.returningFlight?.dateOfDeparture else {return }
        let departureReturnDate = formattedDateFromString(dateString: dateFormatForReturnDeparture, withFormat: "E MMM, MM")
        guard let dateFormatForReturnArrival = bookingArray?.returningFlight?.dateOfArrival else {return}
        let arrivalReturnDate = formattedDateFromString(dateString: dateFormatForReturnArrival, withFormat: "E MMM, MM")
        
        returnTicketdirectionLocation.text = bookingArray?.returningFlight?.departureAirport
        returnTickettoLocation.text = bookingArray?.returningFlight?.arrivalAirport
        returnTicketnameUserNameOutlet.text = bookingArray?.name
        returnTicketsurnameUserOutlet.text = bookingArray?.surname
        returnTicketdepartureTimeOutlet.text = bookingArray?.returningFlight?.timeOfDeparture
        returnTicketdateDepartureOutlet.text = departureReturnDate
        returnTicketarrivalTimeOutlet.text = bookingArray?.returningFlight?.timeOfArrival
        returnTicketarrivalDateOutlet.text = arrivalReturnDate
        returnTicketdurationOutlet.text = bookingArray?.returningFlight?.duration
        returnTicketFlightNumber.text = bookingArray?.returningFlight?.flightNumber
        returnTicketgateOutlet.text = bookingArray?.returningFlight?.gate
    }
    
    
    private func setupUI() {
        viewScroll.backgroundColor = AppColors.almostWhite
        directionLocation.adjustsFontSizeToFitWidth = true
        toLocation.adjustsFontSizeToFitWidth = true
        
        returnTicketdirectionLocation.adjustsFontSizeToFitWidth = true
        returnTickettoLocation.adjustsFontSizeToFitWidth = true
        
        // Make flight icons red
           iconFlight.image = iconFlight.image?.withRenderingMode(.alwaysTemplate)
           iconFlight.tintColor = AppColors.newRedColorForALL
           
           secondIconFLight.image = secondIconFLight.image?.withRenderingMode(.alwaysTemplate)
           secondIconFLight.tintColor = AppColors.newRedColorForALL
    }
    
    private func setupNagivation() {
        let barAppearance = UINavigationBarAppearance()

           barAppearance.backgroundColor = AppColors.newRedColorForALL
            barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
            extendedLayoutIncludesOpaqueBars = true
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"

        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    

    @IBAction func BackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
