//
//  FindMyBookingCell.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 4.10.21..
//

import UIKit

class FindMyBookingCell: UITableViewCell {
    
    @IBOutlet weak var DateBookings: UILabel!
    @IBOutlet weak var NameDirectionFlight: UILabel!
    @IBOutlet weak var ConfirmationCode: UILabel!
    @IBOutlet weak var contentViewv: UIView!
    @IBOutlet weak var viewForCode: UIView!
    @IBOutlet weak var secondView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        contentViewv.backgroundColor = AppColors.almostWhite
        viewForCode.backgroundColor = AppColors.veryLightBlue
        
        secondView.shadowVeiw()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
