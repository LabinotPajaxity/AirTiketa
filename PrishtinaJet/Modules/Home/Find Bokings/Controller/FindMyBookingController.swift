//
//  FindMyBookingController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 4.10.21..
//

import UIKit

class FindMyBookingController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var airportdirectionLabel: UILabel!
    @IBOutlet weak var confirmationCodeLabel: UILabel!
    @IBOutlet weak var viewConfirmation: UIView!
    @IBOutlet weak var mainViewUP: UIView!
    @IBOutlet weak var stackViewForDate: UIStackView!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarStack: UIImageView!
    @IBOutlet weak var noBookingLabel: UILabel!
    @IBOutlet weak var BookNowButtonOutlet: UIButton!
    
    var lastName : String = " "
    var confirmationCode: String = " "
    var model : ReservationDetail?
    

    override func viewDidLoad() {
          super.viewDidLoad()
          
          setupNavigationBar()
          setupBookNowButton()
          getMyFinderBooking()
          
          viewConfirmation.backgroundColor = AppColors.veryLightBlue
          tableView.separatorStyle = .none
          tableView.backgroundColor = AppColors.almostWhite
        view.backgroundColor = AppColors.newRedColorForALL
      }
      
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.newRedColorForALL
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }

      
      private func setupBookNowButton() {
          BookNowButtonOutlet.backgroundColor = AppColors.newRedColorForALL
          BookNowButtonOutlet.setTitleColor(.white, for: .normal)
          BookNowButtonOutlet.layer.cornerRadius = 8
          BookNowButtonOutlet.clipsToBounds = true
      }
      
      private func getMyFinderBooking() {
          FindMyBooking.instance.findMyBooking(lastName: lastName, confirmationCode: Int(confirmationCode)!) { result in
              switch result {
              case .success(let response):
                  self.calendarStack.isHidden = true
                  self.noBookingLabel.isHidden = true
                  self.BookNowButtonOutlet.isHidden = true
                  
                  self.model = response
                  self.tableView.reloadData()
                  
                  let Go = response.travelers?.first?.departureFlight?.departureAirport
                  let back = response.travelers?.first?.departureFlight?.arrivalAirport
                  let arriv = response.travelers?.first?.returningFlight?.arrivalAirport
                  let confrimCode: String = String((response.confirmationCode)!)
                  
                  self.confirmationCodeLabel.text = confrimCode
                  
                  if Go != nil {
                      self.airportdirectionLabel.text = ""
                  } else {
                      self.airportdirectionLabel.text = Go
                  }
                  
                  if back != nil {
                      self.airportdirectionLabel.text = Go! + " - " + back!
                  } else {
                      self.airportdirectionLabel.text = Go!
                  }
                  if arriv != nil {
                      self.airportdirectionLabel.text = Go! + " - " + back! + " - " + arriv!
                  } else {
                      self.airportdirectionLabel.text = Go! + " - " + back!
                      print("arriv is nil")
                  }
                  
                  self.dateLabel.text = self.model?.travelers?.first?.departureFlight?.dateOfDeparture
                  
              case .failure(let error):
                  self.calendarStack.isHidden = false
                  self.noBookingLabel.isHidden = false
                  self.BookNowButtonOutlet.isHidden = false
                  self.airportdirectionLabel.isHidden = true
                  self.viewConfirmation.isHidden = true
                  self.stackViewForDate.isHidden = true
                  self.mainViewUP.backgroundColor = AppColors.almostWhite
                  print(error)
              }
          }
      }
      
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookNowAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}


extension FindMyBookingController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.travelers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindMyBookingCell", for: indexPath) as! FindMyBookingCell
        let confirmationCode: Int = model?.confirmationCode ?? 0
        let confirmCode = String(confirmationCode)
        let dateOfDeparture = model?.travelers?.first?.departureFlight?.dateOfDeparture
        let Go = model?.travelers?.first?.departureFlight?.departureAirport
        let back = model?.travelers?.first?.departureFlight?.arrivalAirport
        let arriv = model?.travelers?.first?.returningFlight?.arrivalAirport
        
        if Go != nil {
            cell.NameDirectionFlight.text = ""
        }else{
            cell.NameDirectionFlight.text = Go!
        }
        
        
        if(back != nil){
            cell.NameDirectionFlight.text = Go!  + " - "  + back!

        }else{
            cell.NameDirectionFlight.text = Go!
        }
        if(arriv != nil){
            cell.NameDirectionFlight.text = Go! + " - "  + back! + " - " + arriv!
        }else{
            cell.NameDirectionFlight.text = Go! + " - "  + back!
        }
        cell.ConfirmationCode.text = confirmCode
        cell.DateBookings.text = dateOfDeparture
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = model?.travelers?[indexPath.row]
        let storyboard = UIStoryboard(name: "Boarding", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "BoardingVC") as! BoardingVC
        vc.boradingArray = data!
        vc.title = "Boarding"
        self.navigationController?.pushViewController (vc, animated: true)
        
    }
}
