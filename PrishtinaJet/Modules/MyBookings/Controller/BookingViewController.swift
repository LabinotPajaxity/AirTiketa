//
//  BookingViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 18.8.21..
//

import UIKit
import Alamofire

class BookingViewController: UIViewController {
   
    

    @IBOutlet weak var viewAlmostWhite: UIView!
    @IBOutlet weak var BookingsTabelView: UITableView!
    @IBOutlet weak var noBookingsStackView: UIStackView!
    @IBOutlet weak var serachTextFeild: UISearchBar!
    
    private lazy var notFoundBooking: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "veryDarkBlue")
        label.text = "No booking found"
        label.isHidden = true
        return label
    }()
    
    var bookings = [Bookings]()
    var filteredProducts = [Bookings]()
    var reservations = [Reservations]()
    var openedBooking = -1
    var searching = false
    var searchedBookings = [Bookings]()
    let viewModelToken = RefreshTokenViewModel()
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyBookingsData()
        // Do any additional setup after loading the view.
        view.backgroundColor = AppColors.navColor
        setupIfNotFoundBookingLabel()
        viewAlmostWhite.backgroundColor = AppColors.almostWhite
        BookingsTabelView.backgroundColor = AppColors.almostWhite
        BookingsTabelView.separatorStyle = .none
        self.BookingsTabelView.register(BookingsHeaderCell.self, forCellReuseIdentifier: "BookingsHeaderCell")
        
        setupNavigation()
        self.serachTextFeild.delegate = self
    }
    
    private func setupNavigation() {
        let barAppearance = UINavigationBarAppearance()

            barAppearance.backgroundColor = AppColors.navColor
            barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
            extendedLayoutIncludesOpaqueBars = true
    }
    
    //MARK: - Get my booking
    func getMyBookingsData(){
        GetMyBookings().perform { result in
            switch result {
                case .success(let bookings):
                if bookings.count > 0 {
                    self.bookings = bookings
                    self.BookingsTabelView.reloadData()
                } else {
                    self.BookingsTabelView.isHidden = true
                }
                case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func setupIfNotFoundBookingLabel() {
        self.view.addSubview(notFoundBooking)
        notFoundBooking.translatesAutoresizingMaskIntoConstraints = false
        notFoundBooking.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notFoundBooking.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    @IBAction func BookNowButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func SearchBarButton( _ sender: Any) {
        serachTextFeild.isHidden = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}


extension BookingViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if(searching) {
            return searchedBookings.count
        } else {
            return bookings.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let booking = searching ? searchedBookings[section] : bookings[section]
        if booking.isOpened ?? false {
            return booking.reservations.count + 1
        } else {
            return  1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = searching ? searchedBookings[indexPath.section] : bookings[indexPath.section]
        
        if indexPath.row == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "BookingsHeaderCell", for: indexPath) as! BookingsHeaderCell
            headerCell.headerLabelYear.text = String(model.year)
            headerCell.backgroundColor = AppColors.almostWhite
            headerCell.imageProperty.image =  UIImage(systemName: "chevron.down")
            headerCell.backgroundColor = .white
            return headerCell
        } else {
          
            let bookingCell = tableView.dequeueReusableCell(withIdentifier: "BookingsCell", for: indexPath) as! BookingsCell
            
            let confirmationCode: Int = model.reservations[indexPath.row - 1].confirmationCode
            let confirmCode = String(confirmationCode)
            
            let direction  = model.reservations[indexPath.row - 1].travelers.first?.departureFlight?.departureAirport
            let dateOfDeparture = model.reservations[indexPath.row - 1].travelers.first?.departureFlight?.dateOfDeparture
            let time = model.reservations[indexPath.row - 1].travelers.first?.departureFlight?.timeOfDeparture
            
            let returndateOfDeparture = model.reservations[indexPath.row - 1].travelers.first?.returningFlight?.dateOfDeparture
            let returntime = model.reservations[indexPath.row - 1].travelers[0].returningFlight?.timeOfArrival
            
            let back = model.reservations[indexPath.row - 1].travelers.first?.departureFlight?.arrivalAirport
            let arriv = model.reservations[indexPath.row - 1].travelers.first?.returningFlight?.arrivalAirport
        
            bookingCell.ConfirmationCode?.text = confirmCode
            if returndateOfDeparture != nil {
                bookingCell.DateBookings.text = dateOfDeparture!  + ", " +  time! + " - " + returndateOfDeparture! + ", " + returntime!
            } else {
                bookingCell.DateBookings.text = dateOfDeparture!  + ", " +  time!
            }
            if(back != nil){
                bookingCell.NameDirectionFlight.text = direction! + " - "  + back!

            }else{
                bookingCell.NameDirectionFlight.text = direction!
                print("x is nil")
            }
            if(arriv != nil){
                bookingCell.NameDirectionFlight.text = direction! + " - "  + back! + " - " + arriv!

            }else{
                bookingCell.NameDirectionFlight.text = direction! + " - "  + back!
                print("arriv is nil")
            }
            return bookingCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = searching ? searchedBookings[indexPath.section] : bookings[indexPath.section]

        
        if indexPath.row == 0 {
            if searching {
                searchedBookings[indexPath.section].isOpened = !(bookings[indexPath.section].isOpened ?? false)
            } else {
                bookings[indexPath.section].isOpened = !(bookings[indexPath.section].isOpened ?? false)
            }
        } else {
            let store = model
            let storyboard = UIStoryboard(name: "DetailsBookings", bundle: nil)
            let profileVC = storyboard.instantiateViewController(identifier: "DetailsBookingsViewController") as! DetailsBookingsViewController
            profileVC.IDReservation = store.reservations[indexPath.row - 1].id
            self.navigationController?.pushViewController (profileVC, animated: true)
            
        }
            tableView.reloadSections([indexPath.section], with: .none)
    }
}

extension BookingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchedBookings = [Bookings]()
        bookings.forEach { booking in
            let newBooking = booking.copy() as! Bookings
            let reservations = newBooking.reservations.filter({ (reservation) -> Bool in
                return String(reservation.confirmationCode).contains(searchText)
            })
            if(reservations.count != 0) {
                newBooking.reservations = reservations
                searchedBookings.append(newBooking)
            }
        }

        if !searchText.isEmpty {
            searching = true
            if searchedBookings.count == 0 {
                notFoundBooking.isHidden = false
            } else {
                notFoundBooking.isHidden = true
            }
        } else {
            searching = false
        }
       BookingsTabelView.reloadData()

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        serachTextFeild.text = ""
        BookingsTabelView.reloadData()
    }
}










































