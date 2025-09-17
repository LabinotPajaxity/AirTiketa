//
//  NoBookingsView.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 15.4.21.
//

import UIKit

class NoBookingsView: UIView {
    private let bookNowButton: BlueButton = {
        let button = BlueButton.newAutoLayout()
        button.setTitle("Book Now", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.layer.cornerRadius = 10
        button.heightConstraint?.constant = 50
        return button
    }()
    
    private let dateImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "my-bookings-date"))
        imageView.autoSetDimensions(to: CGSize(width: 23, height: 25))
        return imageView
    }()
    
    private let noBookingsLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = AppColors.darkBlue
        label.textAlignment = .center
        label.text = "No Bookings yet"
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
    
    private func addSubviews() {
        [dateImageView, noBookingsLabel, bookNowButton]
            .forEach(self.addSubview)
    }
    
    private func setupConstraints() {
        noBookingsLabel.autoPinSidesSuperView(with: 10)
        noBookingsLabel.autoAlignAxis(.horizontal, toSameAxisOf: self, withOffset: -50)
        
        dateImageView.autoPinEdge(.bottom, to: .top, of: noBookingsLabel, withOffset: -15)
        dateImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        bookNowButton.autoPinEdge(.top, to: .bottom, of: noBookingsLabel, withOffset: 30)
        bookNowButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }
}
