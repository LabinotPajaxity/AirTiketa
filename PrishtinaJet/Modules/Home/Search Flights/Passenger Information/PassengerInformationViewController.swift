//
//  PassengerInformationViewController.swift
//  PrishtinaJet
//

import UIKit

protocol PassengersInformationControllerDelegate: AnyObject {
    func didCompletePassengerInfo(_ passenger: Passenger)
}

/// MARK: - Custom Birthday Input
final class BirthdayInputView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = AppColors.almostBlack
        label.text = "Birthday"
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 16)
        field.textColor = AppColors.almostBlack
        field.backgroundColor = .clear
        field.layer.cornerRadius = 6
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Enter here"
        field.setLeftPaddingPoints(8)
        field.setRightPaddingPoints(8)
        field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return field
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        picker.backgroundColor = .systemBackground
        picker.layer.cornerRadius = 10
        picker.clipsToBounds = true
        return picker
    }()
    
    var onDateChanged: ((String) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        setupDatePicker()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [label, textField])
        stack.axis = .vertical
        stack.spacing = 6
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupDatePicker() {
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDateChange), for: .valueChanged)
        
        // Toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        ], animated: true)
        textField.inputAccessoryView = toolBar
    }
    
    @objc private func handleDateChange() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateStr = formatter.string(from: datePicker.date)
        textField.text = dateStr
        onDateChanged?(dateStr)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    var text: String? { textField.text }
    func configureMaxDate(for type: PassengerSelectionType) {
        var components = DateComponents()
        let now = Date()
        switch type {
        case .adult: components.year = -15
        case .child: components.year = -3
        case .inf: components.year = 0
        }
        let maxDate = Calendar.current.date(byAdding: components, to: now)
        datePicker.maximumDate = maxDate
    }
}


/// MARK: - Controller
final class PassengersInformationViewController: UIViewController {
    
    weak var delegate: PassengersInformationControllerDelegate?
    private var passenger: Passenger
    private var isBirthdaySelected = false
    
    // UI
    private let passengerLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = AppColors.darkBlue
        return label
    }()
    
    private let genderControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["FEMALE", "MALE"])
        segmented.selectedSegmentIndex = 1
        let attrs = [NSAttributedString.Key.foregroundColor: AppColors.almostBlack]
        segmented.setTitleTextAttributes(attrs, for: .normal)
        segmented.setTitleTextAttributes(attrs, for: .selected)
        return segmented
    }()
    
    private let nameInput: PassengersInputView = {
        let v = PassengersInputView.newAutoLayout()
        v.title = "Name"
        return v
    }()
    
    private let surnameInput: PassengersInputView = {
        let v = PassengersInputView.newAutoLayout()
        v.title = "Surname"
        return v
    }()
    
    private let birthdayInput = BirthdayInputView()
    
    private lazy var continueButton: ContinueButtonView = {
        let v = ContinueButtonView.newAutoLayout()
        v.continueButton.isEnabled = true
        v.delegate = self
        return v
    }()
    
    // Init
    init(passenger: Passenger) {
        self.passenger = passenger
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.almostWhite
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "Passenger Information"
        passengerLabel.text = "Passenger - \(passenger.type.title.capitalized)"
        
        nameInput.value = passenger.name
        surnameInput.value = passenger.surname
        birthdayInput.configureMaxDate(for: passenger.type)
        
        birthdayInput.onDateChanged = { [weak self] _ in
            self?.isBirthdaySelected = true
        }
        
        [passengerLabel, genderControl, nameInput, surnameInput, birthdayInput, continueButton]
            .forEach(view.addSubview)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        passengerLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 27, left: 24, bottom: 0, right: 24), excludingEdge: .bottom)
        genderControl.autoPinBelow(view: passengerLabel, top: 24, left: 24, right: 24)
        nameInput.autoPinBelow(view: genderControl, top: 24, left: 24, right: 24)
        surnameInput.autoPinBelow(view: nameInput, top: 24, left: 24, right: 24)
        birthdayInput.autoPinBelow(view: surnameInput, top: 24, left: 24, right: 24)
        continueButton.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .top)
    }
    
    private func validateFields() -> String? {
        if (nameInput.value ?? "").isEmpty { return "Please type name of passenger" }
        if (surnameInput.value ?? "").isEmpty { return "Please type surname of passenger" }
        if !isBirthdaySelected { return "Please select birthday" }
        return nil
    }
}

// MARK: - ContinueButtonDelegate
extension PassengersInformationViewController: ContinueButtonDelegate {
    func didTapContinueButton() {
        if let error = validateFields() {
            showErrorAlert(message: error)
            return
        }
        
        passenger.name = nameInput.value ?? ""
        passenger.surname = surnameInput.value ?? ""
        passenger.birthday = birthdayInput.text
        passenger.sex = genderControl.titleForSegment(at: genderControl.selectedSegmentIndex)?.uppercased()
        
        delegate?.didCompletePassengerInfo(passenger)
        navigationController?.popViewController(animated: true)
    }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UIDatePicker {
    /// set the date picker values and set min/max
    /// - parameter date: Date to set the picker to
    /// - parameter unit: (years, days, months, hours, minutes...)
    /// - parameter deltaMinimum: minimum date delta in units
    /// - parameter deltaMaximum: maximum date delta in units
    /// - parameter animated: Whether or not to use animation for setting picker
    func setDate(_ date:Date, unit:NSCalendar.Unit, deltaMinimum:Int, animated:Bool)
    {
        setDate(date, animated: animated)

        setMinMax(unit: unit, deltaMinimum: deltaMinimum)
    }

    /// set the min/max for the date picker (uses the pickers current date)
    /// - parameter unit: (years, days, months, hours, minutes...)
    /// - parameter deltaMinimum: minimum date delta in units
    /// - parameter deltaMaximum: maximum date delta in units
    func setMinMax(unit:NSCalendar.Unit, deltaMinimum:Int)
    {
        if let gregorian = NSCalendar(calendarIdentifier:.gregorian)
        {
            if let minDate = gregorian.date(byAdding: unit, value: deltaMinimum, to: self.date)
            {
                minimumDate = minDate
            }
        }
    }
}
