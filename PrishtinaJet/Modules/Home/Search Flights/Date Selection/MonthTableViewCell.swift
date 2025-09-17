//
//  MonthTableViewCell.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 3/19/21.
//

import UIKit

class MonthTableViewCell: UITableViewCell {
    private let monthNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.textColor = AppColors.almostBlack
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.autoSetDimension(.height, toSize: 20)
        return label
    }()
    
    private let daysInitalsStackView: UIStackView = {
        let stackView = UIStackView.newAutoLayout()
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.autoSetDimension(.height, toSize: 12)
        return stackView
    }()
    
    let monthCollectionView: MonthCollectionView = {
        return MonthCollectionView.newAutoLayout()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with date: Date, tableView: UITableView) {
        monthNameLabel.text = date.monthName
        monthCollectionView.date = date
        frame = tableView.bounds
        layoutIfNeeded()
    }
    
    private func addSubviews() {
        [monthNameLabel, daysInitalsStackView, monthCollectionView].forEach(contentView.addSubview)
        
        Calendar.current.weekdaySymbols.forEach {
            let label = UILabel.newAutoLayout()
            label.text = String($0.prefix(1))
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.textColor = AppColors.darkGray
            daysInitalsStackView.addArrangedSubview(label)
        }
    }
    
    private func setupConstraints() {
        monthNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        monthNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 24)
        
        daysInitalsStackView.autoPinBelow(view: monthNameLabel, top: 30, left: 10, right: 10)
        
        monthCollectionView.autoPinBelow(view: daysInitalsStackView, top: 24, left: 10, right: 10)
        monthCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
    }
}
