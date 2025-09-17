//
//  InputTextField.swift
//  PrishtinaJet
//

import UIKit

final class InputTextField: UITextField {

    // MARK: - Eye Button
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(eyeButtonAction), for: .touchUpInside)
        button.imageView?.tintColor = AppColors.gray
        return button
    }()

    override var isSecureTextEntry: Bool {
        didSet { updateEyeButton() }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Setup
    private func commonInit() {
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        backgroundColor = .clear

        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor // Inactive = light gray

        delegate = self
        updateEyeButton()
    }

    // MARK: - Padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 0)
    }

    // MARK: - Eye Button
    private func updateEyeButton() {
        if isSecureTextEntry {
            rightView = eyeButton
            rightViewMode = .always
        } else {
            rightView = nil
            rightViewMode = .never
        }
    }

    @objc private func eyeButtonAction() {
        // Toggle secure text (system quirk-safe)
        let wasFirstResponder = isFirstResponder
        let currentText = text
        isSecureTextEntry.toggle()
        text = currentText
        if wasFirstResponder { becomeFirstResponder() }

        let iconName = isSecureTextEntry ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: iconName), for: .normal)
    }

    // MARK: - Validation helpers (local)
    private func isEmailValid(_ value: String) -> Bool {
        // Simple, practical email check
        let pattern =
        "(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: value)
    }

    private func isPhoneValid(_ value: String) -> Bool {
        // E.164-like check; allows + and 7–15 digits total
        let pattern = "^\\+?[1-9]\\d{6,14}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: value)
    }

    private func updateBorderForEndEditing() {
        let textValue = (text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        switch keyboardType {
        case .phonePad:
            // If user typed something and it's invalid, keep red; otherwise inactive gray
            if !textValue.isEmpty && !isPhoneValid(textValue) {
                layer.borderColor = UIColor.systemRed.cgColor
            } else {
                layer.borderColor = UIColor.lightGray.cgColor
            }

        case .emailAddress:
            if !textValue.isEmpty && !isEmailValid(textValue) {
                layer.borderColor = UIColor.systemRed.cgColor
            } else {
                layer.borderColor = UIColor.lightGray.cgColor
            }

        default:
            layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}

// MARK: - UITextFieldDelegate
extension InputTextField: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Active = red
        layer.borderColor = UIColor.systemRed.cgColor
        backgroundColor = .clear
        textField.addDoneButtonOnKeyboard()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundColor = .clear
        updateBorderForEndEditing()
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        // Phone rules: limit length (including +), optionally you can add allowed chars filter
        if textField.keyboardType == .phonePad {
            let maxLength = 14
            let current = textField.text ?? ""
            guard let rangeInText = Range(range, in: current) else { return false }
            let updated = current.replacingCharacters(in: rangeInText, with: string)
            return updated.count <= maxLength
        }

        // Default rules: letters and space only (your original regex intent)
        if textField.keyboardType == .default {
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
                let nsString = string as NSString
                let fullRange = NSRange(location: 0, length: nsString.length)
                if regex.firstMatch(in: string, options: [], range: fullRange) != nil {
                    return false
                }
            } catch {
                print("Regex error: \(error)")
            }
        }

        return true
    }
}

// MARK: - InputViewType
extension InputTextField: InputViewType {
    var value: String? {
        get { text }
        set { text = newValue }
    }
}
