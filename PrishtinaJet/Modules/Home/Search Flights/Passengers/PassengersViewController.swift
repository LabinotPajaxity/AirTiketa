//
//  PassengersViewController.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 15.4.21.
//

import UIKit

class PassengersViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset.top = 16
        tableView.register(cellClass: PassengersCell.self)
        return tableView
    }()
    
    var passengerIndexRow: Int = 0

    // MARK: - Footer View
    private lazy var footerView: UIView = {
        let footer = UIView()
        footer.backgroundColor = .white
        
        let containerView = ShadowView()
        containerView.backgroundColor = .white
        containerView.addShadowBorder(radius: 7)
        
        let stackViewTextFields = UIStackView(arrangedSubviews: [
            contactPersonLabel,
            fullNameLabel, fullNameTextField,
            emailLabel, emailTextField,
            phoneNumber, phoneNumberTextField
        ])
        stackViewTextFields.axis = .vertical
        stackViewTextFields.spacing = 8
        
        // Terms + Checkbox row
        let termsStack = UIStackView(arrangedSubviews: [checkBox, termsAndConditions])
        termsStack.axis = .horizontal
        termsStack.spacing = 8
        termsStack.alignment = .center
        
        // 🔹 Make whole row tappable
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTermsStack))
        termsStack.isUserInteractionEnabled = true
        termsStack.addGestureRecognizer(tapGesture)
        
        let termsLinksStack = UIStackView(arrangedSubviews: [termsOfUse, andInMiddle, privacyPolicy])
        termsLinksStack.axis = .horizontal
        termsLinksStack.spacing = 4
        
        let bottomStack = UIStackView(arrangedSubviews: [totalPriceLabel, continueButtonView])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 16
        bottomStack.distribution = .fillProportionally
        
        let mainStack = UIStackView(arrangedSubviews: [
            stackViewTextFields,
            termsStack,
            termsLinksStack,
            bottomStack
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        
        containerView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        footer.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: footer.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: footer.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: footer.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: footer.bottomAnchor, constant: -16)
        ])
        
        return footer
    }()
    
    // MARK: - UI Elements
    private var contactPersonLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact Person for this trip"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = AppColors.almostBlack
        return label
    }()
    
    private lazy var fullNameLabel: UILabel = { makeLabel(title: "Full Name") }()
    private let fullNameTextField: InputTextField = {
        let textField = InputTextField()
        textField.placeholder = "Full Name"
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    private lazy var emailLabel: UILabel = { makeLabel(title: "Email Address") }()
    private let emailTextField: InputTextField = {
        let textField = InputTextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = "Email Address"
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    private lazy var phoneNumber: UILabel = { makeLabel(title: "Phone Number") }()
    private let phoneNumberTextField: InputTextField = {
        let textField = InputTextField()
        textField.keyboardType = .phonePad
        textField.placeholder = "Phone number"
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    private lazy var checkBox: CheckBox = {
        let box = CheckBox()
        box.isChecked = false
        return box
    }()

    private var termsAndConditions: UILabel = {
        let label = UILabel()
        label.text = "I accept the Terms and Conditions"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private lazy var termsOfUse: UILabel = {
        let label = makeLabel(title: "Terms of Use")
        label.textColor = AppColors.lightBlue
        return label
    }()
    
    private lazy var andInMiddle: UILabel = { makeLabel(title: "&") }()
    
    private lazy var privacyPolicy: UILabel = {
        let label = makeLabel(title: "Privacy Policy")
        label.textColor = AppColors.lightBlue
        return label
    }()
    
    private var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = AppColors.almostBlack
        return label
    }()
    
    private lazy var continueButtonView: ContinueButtonView = {
        let view = ContinueButtonView()
        view.continueButton.setTitle("Confirm & Pay", for: .normal)
        
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    let viewModel: PassengersViewModel
    let selectedFlight: SelectedFlightModel
    var totalPriceDelegate: String = " "
    
    // MARK: - Init
    init(viewModel: PassengersViewModel, selectedFlight: SelectedFlightModel) {
        self.viewModel = viewModel
        self.selectedFlight = selectedFlight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Passengers"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.tableFooterView = footerView
        
        // Pre-fill fields
        emailTextField.text = KeychainManager.shared.accessEmail
        fullNameTextField.text = KeychainManager.shared.accessUsername
        totalPriceLabel.text = totalPriceDelegate
    }
    
    private func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let footer = tableView.tableFooterView {
            let size = footer.systemLayoutSizeFitting(
                CGSize(width: tableView.frame.width, height: 0),
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
            
            if footer.frame.height != size.height {
                footer.frame.size.height = size.height
                tableView.tableFooterView = footer
            }
        }
    }
    
    // 🔹 Toggle checkbox when whole row tapped
    @objc private func didTapTermsStack() {
        checkBox.isChecked.toggle()
    }
    
    // 🔹 Shake animation helper
    private func shakeView(_ view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }

}
extension PassengersViewController: ContinueButtonDelegate {
    func didTapContinueButton() {
        let passanger = viewModel.model.passengers.contains(where: { $0.name == nil })
        if passanger {
            showErrorAlert(message: "Please fill the data for passanger")
        } else if checkBox.isChecked == false {
            shakeView(checkBox)
            showErrorAlert(message: "Please accept Terms and Conditions to continue")
        } else if fullNameTextField.text == "" {
            showErrorAlert(message: "Please type FullName")
        } else if !isValidEmail(testStr: emailTextField.text!) {
            self.showErrorAlert(message: "Email not valid")
        } else if emailTextField.text == "" {
            showErrorAlert(message: "Please type Email address")
        } else if phoneNumberTextField.text?.count == 0 {
            showErrorAlert(message: "Please type phone number")
        } else if !isValidPhoneNumber(phone: phoneNumberTextField.text!) {
            showErrorAlert(message: "Phone number not valid")
        } else {
            // ✅ ruaj të dhënat
            UserDefaults.standard.setcontactNumber(value: phoneNumberTextField.text!)
            KeychainManager.shared.store(username: fullNameTextField.text!)
            KeychainManager.shared.store(email: emailTextField.text!)
            UserDefaults.standard.setPaymentType(value: "STRIPE")
            
            continueButtonView.showLoading(true)
            
            Payment(viewModel: viewModel).perform { result in
                DispatchQueue.main.async {
                    // 🔹 ndal loading gjithmonë
                    self.continueButtonView.showLoading(false)
                    
                    switch result {
                    case .success(let path):
                        let vc = PaymentInWebView()
                        vc.responseUrl = [path]
                        vc.hidesBottomBarWhenPushed = true
                        UIView.transition(with: self.navigationController!.view,
                                          duration: 0.6,
                                          options: .transitionFlipFromRight,
                                          animations: {
                            self.navigationController?.pushViewController(vc, animated: false)
                        })
                    case .failure(let error):
                        self.showErrorAlert(message: error.localizedDescription)
                    }
                }
            }
        }
    }
}
