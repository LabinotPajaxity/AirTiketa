//
//  BookingsHeaderCell.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 20.8.21..
//

import UIKit

class BookingsHeaderCell: UITableViewCell {
    
     var headerLabelYear : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .center
    return lbl
    }()
    
     var imageProperty : UIImageView = {
        let imageVie = UIImageView()
        imageVie.image =  UIImage(named: "chevron.down")
        
        return imageVie
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitle()
        setupImage()
    }
    
    private func setupTitle() {
        addSubview(headerLabelYear)
        headerLabelYear.translatesAutoresizingMaskIntoConstraints = false
        let top = headerLabelYear.topAnchor.constraint(equalTo: topAnchor,constant: 10)
        let leading = headerLabelYear.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10)
        NSLayoutConstraint.activate([top,leading])
    }
    
    
    private func setupImage() {
        addSubview(imageProperty)
        imageProperty.translatesAutoresizingMaskIntoConstraints = false
        let top = imageProperty.topAnchor.constraint(equalTo: topAnchor,constant: 10)
        let trailing = imageProperty.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10)
        NSLayoutConstraint.activate([top,trailing])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
