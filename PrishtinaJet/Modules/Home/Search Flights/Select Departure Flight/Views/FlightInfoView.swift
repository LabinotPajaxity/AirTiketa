//
//  FlightInfoView.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 26.5.21.
//

import UIKit

class FlightInfoView: UIView {
    let containerView: ShadowView = {
        let view = ShadowView.newAutoLayout()
        view.backgroundColor = .white
        view.addShadowBorder(radius: 7)
        view.autoSetDimension(.height, toSize: 160)
        return view
    }()
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    let leftView: UIView = {
        let view = UIView()
        return view
    }()
    
    let middleView: UIView = {
        let view = UIView()
        return view
    }()
    
    let rightView: UIView = {
        let view = UIView()
        return view
    }()
    
    let soldLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = AppColors.darkBlueForLabel
        return label
    }()
    
    let departureTimeLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.textColor = AppColors.darkBlueForLabel
        return label
    }()
    
    let arrivalTimeLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.textColor = AppColors.darkBlueForLabel
        return label
    }()
    
    let departurePlaceLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.textColor = AppColors.darkGray
        return label
    }()
    
    let arrivalPlaceLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.textColor = AppColors.darkGray
        return label
    }()
    
    let flightDurationLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.textColor = AppColors.darkBlueForLabel
        return label
    }()
    
    let seatsLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = AppColors.darkBlueForLabel
        return label
    }()
    let middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let directFlightLabel: UILabel = {
            let label = UILabel.newAutoLayout()
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textAlignment = .center
            label.textColor = AppColors.darkGray
            label.text = "Direct Flight"
            return label
        }()

        let flightNumberLabel: UILabel = {
            let label = UILabel.newAutoLayout()
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textAlignment = .center
            label.textColor = AppColors.darkGray
            label.text = "Flight"
            return label
        }()

        let baggageInfoLabel: UILabel = {
            let label = UILabel.newAutoLayout()
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textAlignment = .center
            label.textColor = AppColors.darkGray
            label.text = "20kg Check-in Baggage"
            return label
        }()
    let priceLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = AppColors.lightBlue
        label.textAlignment = .center
        label.backgroundColor = AppColors.veryLightBlue
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        [departureTimeLabel, departurePlaceLabel]
            .forEach(leftView.addSubview)
        
        // Add flightDuration & seats directly to middleView
        [flightDurationLabel, seatsLabel].forEach(middleView.addSubview)
        
        // Put the 3 labels inside the stackView
        [directFlightLabel, flightNumberLabel, baggageInfoLabel]
            .forEach(middleStackView.addArrangedSubview)
        
        middleView.addSubview(middleStackView)
        
        [arrivalPlaceLabel, arrivalTimeLabel]
            .forEach(rightView.addSubview)
        
        [leftView, middleView, rightView]
            .forEach(horizontalStackView.addArrangedSubview)
        
        [horizontalStackView, priceLabel, soldLabel]
            .forEach(containerView.addSubview)
        
        addSubview(containerView)
    }

        
        // MARK: - Constraints
    private func setupConstraints() {
        // Sold label fills container
        soldLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        soldLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        soldLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        soldLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        soldLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        // Left column
        departurePlaceLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        departurePlaceLabel.autoPinSidesSuperView()
        
        departureTimeLabel.autoPinEdge(.top, to: .bottom, of: departurePlaceLabel, withOffset: 4)
        departureTimeLabel.autoPinSidesSuperView()

        // Middle column
        flightDurationLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        flightDurationLabel.autoPinSidesSuperView()
        
        seatsLabel.autoPinBelow(view: flightDurationLabel, top: 6)
        seatsLabel.autoPinSidesSuperView()
        
        // Middle column stack (no leading/trailing padding)
        middleStackView.topAnchor.constraint(equalTo: seatsLabel.bottomAnchor, constant: 6).isActive = true
        middleStackView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor).isActive = true
        middleStackView.trailingAnchor.constraint(equalTo: middleView.trailingAnchor).isActive = true
        middleStackView.bottomAnchor.constraint(lessThanOrEqualTo: middleView.bottomAnchor, constant: -8).isActive = true


        // Make middle wider than sides
        middleView.widthAnchor.constraint(equalTo: leftView.widthAnchor, multiplier: 1.6).isActive = true
        middleView.widthAnchor.constraint(equalTo: rightView.widthAnchor, multiplier: 1.6).isActive = true

        // Right column
        arrivalPlaceLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        arrivalPlaceLabel.autoPinSidesSuperView()
        
        arrivalTimeLabel.autoPinEdge(.top, to: .bottom, of: arrivalPlaceLabel, withOffset: 4)
        arrivalTimeLabel.autoPinSidesSuperView()
        
        // Horizontal stack fills container except bottom
        horizontalStackView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        
        // Price label sticks to bottom
        priceLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        priceLabel.autoSetDimension(.height, toSize: 48)
        
        // Container
        containerView.autoPinEdge(toSuperviewEdge: .top)
        containerView.autoPinEdge(toSuperviewEdge: .bottom)
        containerView.autoPinSidesSuperView(with: 16)
    }

    }

