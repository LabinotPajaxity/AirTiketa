//
//  DetailsBookingsViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 23.8.21..
//

import UIKit

class DetailsBookingsViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var airportdirectionLabel: UILabel!
    @IBOutlet weak var confirmationCodeLabel: UILabel!
    @IBOutlet weak var viewConfirmation: UIView!
    @IBOutlet weak var viewSeconds: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var booking: ReservationDetailModel?
    
    var IDReservation : String = " "
    var isPaymentDetail: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMydetailReservationsData()
        setupDesign()
       
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        
        if isPaymentDetail == true {
            setupNavigation()
        } else {
            navigationController?.setNavigationBarHidden(false, animated: animated)
            navigationNormal()
        }
      }
    
    //MARK: - This navigation bar called if user finish payment
    private func setupNavigation() {
        navigationItem.title = "Detail"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // ensures solid color
        appearance.backgroundColor = AppColors.newRedColorForALL
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(addAction))
        addButton.tintColor = .white
        navigationItem.leftBarButtonItem = addButton
    }

    
    private func navigationNormal() {
        let barAppearance = UINavigationBarAppearance()

        barAppearance.backgroundColor = AppColors.newRedColorForALL
            barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
            extendedLayoutIncludesOpaqueBars = true
    }
    
    @objc private func addAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    //MARK: - Setup UI
    private func setupDesign() {
        view.backgroundColor = AppColors.newRedColorForALL
        viewConfirmation.backgroundColor = AppColors.veryLightBlue
        viewSeconds.backgroundColor = AppColors.almostWhite
        tableView.separatorStyle = .none
        tableView.backgroundColor = AppColors.almostWhite
        
        // Make airportdirectionLabel red
        airportdirectionLabel.textColor = AppColors.newRedColorForALL
    }

    
    //MARK: - Get api for my reservation detail
    func getMydetailReservationsData(){
        DetailMyBookingServices.instance.getBookingFromSession(sessionId: IDReservation, completion: { result in
            switch result {
                case .success(let bookingDetail):
                self.booking = bookingDetail
                print(bookingDetail)
                let directionFlight = bookingDetail.travelers.first?.departureFlight?.departureAirport
                let returnFlight = bookingDetail.travelers.first?.departureFlight?.arrivalAirport
                self.confirmationCodeLabel.text = String(bookingDetail.confirmationCode!)
                
                if(returnFlight != nil){
                    self.airportdirectionLabel.text = directionFlight!  + " - "  + returnFlight!

                }else{
                    self.airportdirectionLabel.text = directionFlight!
                }
                self.dateLabel.text = bookingDetail.travelers.first?.departureFlight?.dateOfDeparture
                    
                        self.tableView.reloadData()
//                
                case .failure(let error):
                    print(error)
                }
        })

    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Extensions

extension DetailsBookingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return booking?.travelers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsBookingsCell", for: indexPath) as! DetailsBookingsCell
        
        let model = booking?.travelers[indexPath.row]
        let name = model?.name
        let surname = model?.surname
        let AgeCategory = model?.ageCategory
        cell.PassenderAdult.text = AgeCategory
//        cell.NameOfPassenger.text = "\(name) \(surname)"
        cell.NameOfPassenger.text = name! + " " + surname!
      
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let data = booking?.travelers[String(indexPath.row)]
        
        let ss = booking?.travelers[indexPath.row]
        let storyboard = UIStoryboard(name: "BoardingPassScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "BoradingPassViewController") as! BoradingPassViewController
        vc.bookingArray = ss!
        
        self.navigationController?.pushViewController (vc, animated: true)
    }
    
    
}
