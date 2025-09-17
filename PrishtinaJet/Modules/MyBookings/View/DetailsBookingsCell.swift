//
//  DetailsBookingsCell.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 23.8.21..
//

import UIKit

class DetailsBookingsCell: UITableViewCell {
    @IBOutlet weak var PassenderAdult: UILabel!
    @IBOutlet weak var NameOfPassenger: UILabel!
    @IBOutlet weak var contentViewv: UIView!
    @IBOutlet weak var secondView: UIView!

    @IBOutlet weak var chevronIcon: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentViewv.backgroundColor = AppColors.almostWhite
        chevronIcon.tintColor = AppColors.newRedColorForALL

        secondView.shadowView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIView {
    func shadowView(){
        layer.cornerRadius = 5
        layer.shadowRadius = 5
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
    }
}
