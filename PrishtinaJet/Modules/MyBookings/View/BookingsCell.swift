//
//  BookingsCell.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 18.8.21..
//

import UIKit

class BookingsCell: UITableViewCell {
    
    @IBOutlet weak var DateBookings: UILabel!
    @IBOutlet weak var NameDirectionFlight: UILabel!
    @IBOutlet weak var ConfirmationCode: UILabel!
    @IBOutlet weak var contentViewv: UIView!
    @IBOutlet weak var viewForCode: UIView!
    @IBOutlet weak var secondView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentViewv.backgroundColor = AppColors.almostWhite
        viewForCode.backgroundColor = AppColors.veryLightBlue
        
        secondView.shadowVeiw()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIView {
    func shadowVeiw(){
        layer.cornerRadius = 5
        layer.shadowRadius = 5
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
    }
}
