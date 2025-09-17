//
//  SideMenuTableViewCell.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/12/21.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    private var iconImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        let size = imageView.autoSetDimensions(to: CGSize(width: 25, height: 25))
        size.last?.priority = .init(999)
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        selectedBackgroundView = view

        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with item: SideMenuItem, isSelected: Bool) {
        iconImageView.image = UIImage(named: item.iconName)
        iconImageView.image = iconImageView.image?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.white
        titleLabel.text = item.title
        selectedBackgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
    
    private func addSubviews() {
        [iconImageView, titleLabel].forEach(contentView.addSubview)
    }
    
    private func setupConstraints() {
        iconImageView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 18, left: 24, bottom: 18, right: 0), excludingEdge: .trailing)
        titleLabel.autoPinEdge(.leading, to: .trailing, of: iconImageView, withOffset: 12)
        titleLabel.autoAlignAxis(.horizontal, toSameAxisOf: iconImageView)
    }

}
