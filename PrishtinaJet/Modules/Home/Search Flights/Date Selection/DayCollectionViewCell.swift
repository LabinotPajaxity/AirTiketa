//
//  DayCollectionViewCell.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/26/21.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    private let roundView: UIView = {
        let view = UIView.newAutoLayout()
        view.layer.cornerRadius = 25
        return view
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.textColor = AppColors.almostBlack
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        roundView.addSubview(dayLabel)
        dayLabel.autoCenterInSuperview()
        contentView.addSubview(roundView)
        roundView.autoPinEdgesToSuperviewEdges()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            setupSelectedCell()
        }
    }
    
    private func setupSelectedCell() {
        if let day = dayLabel.text, !day.isEmpty {
            roundView.backgroundColor = isSelected ? AppColors.lightBlue : .white
            dayLabel.textColor = isSelected ? .white : AppColors.almostBlack
        }
    }
}
