//
//  HomeViewController.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/8/21.
//

import UIKit
import SideMenu

class HomeViewController: TabbableViewController {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.image = UIImage(named: "NewLogo")
        
        return imageView
    }()
    
    lazy var  searchFlightsButton: BlueButton = {
        let button = BlueButton.newAutoLayout()
        button.setTitle("Search for Flights", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.heightConstraint?.constant = 50
        button.addTarget(self, action: #selector(searchFlightsButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var findBookingsButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setTitle("Find My Bookings", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.autoSetDimension(.height, toSize: 50)
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.setTitleColor(AppColors.newRedColorForALL, for: .normal)
        button.addTarget(self, action: #selector(findBookingsButtonAction), for: .touchUpInside)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView.newAutoLayout()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
                   .addObserver(self,
                    selector: #selector(statusManager),
                    name: .flagsChanged,
                    object: nil)
        updateUserInterface()
        addSubviews()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide navigation bar completely
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Restore navigation bar for next screens
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @objc func searchFlightsButtonAction() {
        let searchFlightsVC = SearchFlightsViewController()
        navigationController?.pushViewController(searchFlightsVC, animated: true)
    }
    
    @objc func findBookingsButtonAction() {
        
        let storyboard = UIStoryboard(name: "FindBookingInputs", bundle: nil)
        let profileVC = storyboard.instantiateViewController(identifier: "FindBookingInputsViewController") as! FindBookingInputsViewController
      
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func addSubviews() {
        [logoImageView, stackView].forEach(view.addSubview)
        [searchFlightsButton, findBookingsButton].forEach(stackView.addArrangedSubview)
    }
    
    func setupConstraints() {        
        logoImageView.autoPinEdge(.bottom, to: .top, of: stackView, withOffset: -120)
        logoImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        stackView.autoAlignAxis(toSuperviewAxis: .horizontal)
        stackView.autoPinSidesSuperView(with: 40)
    }

}
