//
//  DateSelectioinView.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 4/16/21.
//

import UIKit

protocol DateSelectionViewDelegate: AnyObject {
    func didSelectDate(_ datePicker: UIDatePicker, date: Date)
}

class DateSelectionView: UIView {
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker.newAutoLayout()
        datePicker.date = Date()
        datePicker.tintColor = AppColors.lightBlue
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .systemBackground
        datePicker.layer.cornerRadius = 10
        datePicker.clipsToBounds = true
        return datePicker
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(AppColors.almostBlack, for: .normal)
        button.autoSetDimensions(to: CGSize(width: 100, height: 40))
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.autoSetDimensions(to: CGSize(width: 100, height: 40))
        button.backgroundColor = AppColors.lightBlue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView.newAutoLayout()
        stackView.spacing = 5
        return stackView
    }()
    
    private let contentView: UIView = {
        let view = UIView.newAutoLayout()
        view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return view
    }()
    
    var date: Date {
        get { return datePicker.date }
        set { datePicker.date = newValue }
    }
    
    weak var delegate: DateSelectionViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0)
        
        addSubviews()
        setupConstraints()
        
        var components = DateComponents()
        components.year = -18
        let maxDate = Calendar.current.date(byAdding: components, to: Date())
        datePicker.maximumDate = maxDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancelButtonAction() {
        dismiss()
    }
    
    @objc func selectButtonAction() {
        delegate?.didSelectDate(datePicker, date: datePicker.date)
        dismiss()
    }
    
    func show() {
        guard let targetView = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            return
        }
        targetView.addSubview(self)
        autoPinEdgesToSuperviewEdges()
        
        UIView.animate(withDuration: 0.25) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.contentView.transform = .identity
        }
    }

    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { done in
            if done {
                self.removeFromSuperview()
            }
        })
    }
    
    private func addSubviews() {
        [datePicker, buttonsStackView].forEach(contentView.addSubview)
        [cancelButton, selectButton].forEach(buttonsStackView.addArrangedSubview)
        addSubview(contentView)
    }
    
    private func setupConstraints() {
        contentView.autoCenterInSuperview()
        contentView.autoPinSidesSuperView(with: 30)
        
        datePicker.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8), excludingEdge: .bottom)
        
        buttonsStackView.autoAlignAxis(toSuperviewAxis: .vertical)
        buttonsStackView.autoPinEdge(.top, to: .bottom, of: datePicker, withOffset: 16)
        buttonsStackView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
}

