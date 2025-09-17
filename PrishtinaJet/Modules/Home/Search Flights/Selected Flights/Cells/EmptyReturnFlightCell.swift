//
//  EmptyReturnFlightCell.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 7.6.21.
//

import UIKit

protocol EmptyReturnFlightCellDelegate: AnyObject {
    func didTapOnReturnButton()
}

class EmptyReturnFlightCell: UITableViewCell {
    
    weak var delegate: EmptyReturnFlightCellDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton.newAutoLayout()
        button.backgroundColor = .white
        button.setTitleColor(AppColors.lightBlue, for: .normal)
        button.setTitle("Continue with Return Flight", for: .normal)
        button.layer.cornerRadius = 10
        button.autoSetDimension(.height, toSize: 50)
        button.addTarget(self, action: #selector(returnButtonAction), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = AppColors.almostWhite
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(button)
    }
    
    private func setupConstraints() {
        button.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    @objc private func returnButtonAction() {
        delegate?.didTapOnReturnButton()
    }
}
