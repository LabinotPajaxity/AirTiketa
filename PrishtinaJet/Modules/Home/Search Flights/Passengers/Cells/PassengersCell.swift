//
//  PassengersCell.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 15.4.21.
//

import UIKit

class PassengersCell: UITableViewCell {
    private let containerView: ShadowView = {
        let view = ShadowView.newAutoLayout()
        view.backgroundColor = .white
        view.addShadowBorder(radius: 7)
        view.autoSetDimension(.height, toSize: 75)
        return view
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AppColors.darkGray
        return label
    }()
    
    private let passengerNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = AppColors.almostBlack
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton.newAutoLayout()
        let image = UIImage(named: "passengers-right-chevron")
        button.setImage(image, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setTitle("Fill Informations", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(AppColors.lightBlue, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = AppColors.almostWhite
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureForBookingDetails(passenger: Passenger, index: Int) {
        if let name = passenger.name {
            descriptionLabel.text = "Passenger  \(index) - \(passenger.type.title)"
            passengerNameLabel.text = name
            button.setTitle("See all", for: .normal)
        } else {
            descriptionLabel.text = "Passenger \(index)"
            passengerNameLabel.text = passenger.type.title
            button.setTitle("Fill informations", for: .normal)
//            button.isEnabled = false
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        [descriptionLabel, passengerNameLabel, button]
            .forEach(containerView.addSubview)
    }
    
    private func setupConstraints() {
        descriptionLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        descriptionLabel.autoPinEdge(.trailing, to: .leading, of: button, withOffset: -10, relation: .greaterThanOrEqual)
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        passengerNameLabel.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 6)
        passengerNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        passengerNameLabel.autoPinEdge(.trailing, to: .trailing, of: descriptionLabel)
        passengerNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        button.autoPinEdge(toSuperviewEdge: .trailing, withInset: 22)
        button.autoAlignAxis(toSuperviewAxis: .horizontal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
    }
}
