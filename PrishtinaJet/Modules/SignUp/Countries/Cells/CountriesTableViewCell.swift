//
//  CountriesTableViewCell.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 27.5.21.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let view = UIView()
        view.backgroundColor = AppColors.blue
        selectedBackgroundView = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        textLabel?.textColor = selected ? .white : .black
    }
}
