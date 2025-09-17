//
//  AirportTableViewCell.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/2/21.
//

import UIKit

class AirportTableViewCell: UITableViewCell {
    
    private lazy var flagImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.textColor = AppColors.almostBlack
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var abbreviationLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = AppColors.darkGray
        return label
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [flagImageView, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with airport: Airport, countryCode: String?) {
        nameLabel.text = airport.name
        abbreviationLabel.text = airport.code
        if let code = countryCode {
            flagImageView.image = generateFlagImage(for: code)
        } else {
            flagImageView.image = nil
        }
    }

    
    private func addSubviews() {
        [nameStackView, abbreviationLabel].forEach(contentView.addSubview)
    }
    
    private func setupConstraints() {
        nameStackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 0), excludingEdge: .trailing)
        abbreviationLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 24), excludingEdge: .leading)
    }
    
    private func generateFlagImage(for countryCode: String) -> UIImage? {
        // Convert country code to emoji flag
        let base: UInt32 = 127397
        var flag = ""
        for scalar in countryCode.uppercased().unicodeScalars {
            if let unicodeScalar = UnicodeScalar(base + scalar.value) {
                flag.unicodeScalars.append(unicodeScalar)
            }
        }
        
        // Render emoji flag into UIImage
        let size = CGSize(width: 36, height: 24) // Bigger size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        (flag as NSString).draw(in: CGRect(origin: .zero, size: size), withAttributes: [
            .font: UIFont.systemFont(ofSize: 28) // Larger font for sharper flag
        ])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
