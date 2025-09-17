//
//  SuccesPaymentViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 16.9.21..
//

import UIKit

class SuccesPaymentViewController: UIViewController {

    @IBOutlet weak var homeDirectionOutlet: UIButton!
    @IBOutlet weak var detailBookingOutlet: UIButton!
    @IBOutlet weak var ShadowView: UIView!
    
    
    var idBooking: String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.almostWhite
        setupUI()
        setupNavigation()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // apply red navbar
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Reset navigation bar to default (used in Home or others)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.navColor   // your default app nav color
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }

    private func setupNavigation() {
           title = "Success"
           
           let appearance = UINavigationBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = AppColors.newRedColorForALL
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           
           navigationController?.navigationBar.standardAppearance = appearance
           navigationController?.navigationBar.scrollEdgeAppearance = appearance
           navigationController?.navigationBar.compactAppearance = appearance
           navigationController?.navigationBar.isTranslucent = false
           navigationItem.setHidesBackButton(true, animated: true)
           
           let closeButton = UIBarButtonItem(
               image: UIImage(systemName: "xmark"),
               style: .done,
               target: self,
               action: #selector(addAction)
           )
           closeButton.tintColor = .white
           navigationItem.leftBarButtonItem = closeButton
       }
       
       @objc private func addAction() {
           navigationController?.popToRootViewController(animated: true)
       }
       
       // MARK: - UI Setup
       private func setupUI() {
           // Home button → transparent background, red border, red text
           configureButton(
               homeDirectionOutlet,
               backgroundColor: .clear,
               textColor: AppColors.newRedColorForALL,
               borderColor: AppColors.newRedColorForALL.cgColor
           )
           
           // Detail button → solid red background, white text
           configureButton(
               detailBookingOutlet,
               backgroundColor: AppColors.newRedColorForALL,
               textColor: .white
           )
           
           configureShadow(for: ShadowView)
       }
       
       /// Reusable button configuration
       private func configureButton(
           _ button: UIButton,
           backgroundColor: UIColor,
           textColor: UIColor,
           borderColor: CGColor? = nil
       ) {
           button.layer.cornerRadius = 10
           button.backgroundColor = backgroundColor
           button.setTitleColor(textColor, for: .normal)
           button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
           
           if let borderColor = borderColor {
               button.layer.borderWidth = 1
               button.layer.borderColor = borderColor
           } else {
               button.layer.borderWidth = 0
               button.layer.borderColor = nil
           }
       }
       
       /// Reusable shadow configuration
       private func configureShadow(for view: UIView) {
           view.layer.cornerRadius = 10
           view.layer.shadowRadius = 5
           view.layer.shadowColor = UIColor.lightGray.cgColor
           view.layer.shadowOpacity = 0.8
           view.layer.shadowOffset = CGSize(width: 1, height: 1)
           view.layer.backgroundColor = UIColor.white.cgColor
           view.layer.masksToBounds = false
       }
       

    @IBAction func homeDirection(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func detailDirection(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "DetailsBookings", bundle: nil)
        let detailBookingVC = storyboard.instantiateViewController(identifier: "DetailsBookingsViewController") as! DetailsBookingsViewController
        detailBookingVC.IDReservation = idBooking  // <-- now a real value
        detailBookingVC.isPaymentDetail = true
        self.navigationController?.pushViewController(detailBookingVC, animated: true)

    }
    
}
