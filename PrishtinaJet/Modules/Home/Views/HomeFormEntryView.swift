//
//  HomeFormEntryView.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/27/21.
//

import UIKit

class HomeFormEntryView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private let buttonWithIcon: ButtonWithIcon = {
        return ButtonWithIcon.newAutoLayout()
    }()
    
    var tapHandler: (() -> ())?
    
    let model: SearchFlightsDataEntry
    
    init(model: SearchFlightsDataEntry) {
        self.model = model
        super.init(frame: .zero)
                
        addBottomBorder(color: .systemGray6, width: 1)
        if model == .departure {
            addRightBorder(color: .systemGray6, width: 1)
        }
        autoSetDimension(.height, toSize: model.height)

        [titleLabel, buttonWithIcon].forEach(addSubview)
        
        titleLabel.text = model.title.uppercased()
        buttonWithIcon.value = model.placeholder
        buttonWithIcon.icon = model.icon
        buttonWithIcon.titleLabel?.font = model.placeholderFont
                
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)

        buttonWithIcon.autoPinSidesSuperView(with: 20)
        buttonWithIcon.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 8)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapGestureAction() {
        tapHandler?()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = AppColors.blue.withAlphaComponent(0.3)
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = .white
        })
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = .white
        })
    }
}

extension HomeFormEntryView: InputViewType {
    var value: String? {
        get { return buttonWithIcon.value }
        set { buttonWithIcon.value = newValue }
    }
}
