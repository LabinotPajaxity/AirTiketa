//
//  PassengersInputView.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 16.4.21.
//  Refactored by ChatGPT on 16.8.25
//

import UIKit

final class PassengersInputView: UIView {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = AppColors.almostBlack
        return label
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 16)
        field.textColor = AppColors.almostBlack
        field.backgroundColor = .clear
        field.layer.cornerRadius = 6
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.delegate = self
        field.placeholder = "Enter here"
        field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        field.setLeftPaddingPoints(8)                       // ✅ padding
        field.setRightPaddingPoints(8)
        return field
    }()

    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField])
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()
    
    // MARK: - Properties
    var value: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    var keyboard: UIKeyboardType {
        get { textField.keyboardType }
        set { textField.keyboardType = newValue }
    }
    
    /// Limit input length (e.g. phone number max digits)
    var maxLength: Int?
    
    /// Called when text changes
    var onTextChanged: ((String) -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
private extension PassengersInputView {
    func setupLayout() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension PassengersInputView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        applyActiveStyle()
        textField.addDoneButtonOnKeyboard()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        applyInactiveStyle()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        
        // Limit length if needed
        if let max = maxLength {
            let current = textField.text ?? ""
            let newText = (current as NSString).replacingCharacters(in: range, with: string)
            if newText.count > max { return false }
        }
        
        // Restrict input for names (letters + spaces only)
        if keyboard == .default {
            let regex = try! NSRegularExpression(pattern: "^[A-Za-z ]*$")
            if regex.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) == nil {
                return false
            }
        }
        
        // Notify caller
        DispatchQueue.main.async {
            self.onTextChanged?(textField.text ?? "")
        }
        
        return true
    }
}

// MARK: - Styling
private extension PassengersInputView {
    func applyActiveStyle() {
        textField.backgroundColor = .clear
        textField.layer.borderColor = AppColors.newRedColorForALL.cgColor   // 🔴 active border
        textField.layer.borderWidth = 1
        titleLabel.textColor = AppColors.almostBlack
    }
    
    func applyInactiveStyle() {
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.lightGray.cgColor            // ⚪️ inactive border
        textField.layer.borderWidth = 1
        titleLabel.textColor = AppColors.almostBlack
    }
}
