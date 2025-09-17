//
//  TitleHeaderView.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/16/21.
//

import UIKit

class TitleHeaderView: UITableViewHeaderFooterView {
    private let titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = AppColors.newRedColorForALL
        return label
    }()

    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue?.uppercased() }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = AppColors.veryLightBlue
        
        contentView.addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
