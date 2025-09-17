//
//  LoginViewController.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/21/21.
//

import UIKit
import SideMenu
//import FormValidation

class LoginViewController: UIViewController {
    var formValidation: FormValidationProtocol?
    
    private let logoBarButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "NewLogo"), for: .normal)
        let barButton = UIBarButtonItem(customView: button)
        barButton.tintColor = .clear
        return barButton
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "SIGN IN"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        return makeLabel(title: "Email Address")
    }()
    
    private let emailTextField: InputTextField = {
        let textField = InputTextField.newAutoLayout()
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.placeholder = "Email Address"
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        return makeLabel(title: "Password")
    }()
    
    private let passwordTextField: InputTextField = {
        let textField = InputTextField.newAutoLayout()
        textField.isSecureTextEntry = true
        textField.keyboardType = .asciiCapable
        textField.placeholder = "Password"
        return textField
    }()
    
    private lazy var errorInput:UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor(red: 0.214, green: 0.276, blue: 0.396, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    private let signInButton: BlueButton = {
        let button = BlueButton.newAutoLayout()
        button.setTitle("Sign in", for: .normal)
//        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var dontHaveAnAccountLabel: UILabel = {
        return makeLabel(title: "Don't have an account?")
    }()
    
    private let signUpButton: UIButton = {
        let button = UnderlinedButton.newAutoLayout()
        button.setTitle("Sign up", for: .normal)
        button.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let viewModel = LoginViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: .myNotificationKey, object: nil)

        errorInput.text = ""
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .myNotificationKey, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        
        addSubviews()
        setupConstraints()
        
        formValidation = FormValidation(
            button: signInButton,
            fields: [emailTextField, passwordTextField],
            handler: onSubmit
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        emailTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func setupNavigationBar() {
        let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = AppColors.navColor
            navigationItem.rightBarButtonItem = logoBarButton
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
            extendedLayoutIncludesOpaqueBars = true
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                               for: UIBarMetrics.default)
    }
    @objc func notificationReceived(_ notification: Notification) {
        guard let text = notification.userInfo?["message"] as? String else { return }
        errorInput.text = text
    }
    
    private func onSubmit() {
        if !isValidEmail(testStr: emailTextField.text!) {
            self.showErrorAlert(message: "Email address is not valid")
        } else {
            viewModel.login(username: emailTextField.text!, password: passwordTextField.text!) { [weak self] result in
                switch result {
                case .success:
                    self?.navigationController?.popViewController(animated: true)
                case .failure(_):
                    self?.showErrorAlert(message: "Bad credentials")
                }
            }
        }
    }
    
    //MARK: - Validation fields
    private func checkForTextFieldIsEmpty() {
        if (emailTextField.text?.isEmpty)! {
            
            emailLabel.textColor = UIColor.systemRed
            emailTextField.layer.borderColor = UIColor.systemRed.cgColor
    
        } else {
            emailLabel.textColor = AppColors.darkBlueForLabel
            emailTextField.layer.borderColor = AppColors.lightBlue.cgColor
        }
        
        if  (passwordTextField.text?.isEmpty)! {
            passwordLabel.textColor = UIColor.systemRed
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            errorInput.text = "Error input message"
            errorInput.textColor = .systemRed
            
        } else {
            passwordLabel.textColor = AppColors.darkBlueForLabel
            passwordTextField.layer.borderColor = AppColors.lightBlue.cgColor
            errorInput.text = ""
        }
    }
    
    @objc private func signUpButtonAction() {
        view.endEditing(true)
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(identifier: "RegisterViewController")
        navigationController?.pushViewController(signUpVC, animated: true)
        
        
    }
    
    @objc
    func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let bottomButtonBaseline = signUpButton.frame.origin.y + signUpButton.frame.height + 5
            let keyboardY = keyboardFrame.cgRectValue.origin.y
            if bottomButtonBaseline > keyboardY && self.view.frame.origin.y == 0 {
                UIView.animate(withDuration: 0.1) {
                    self.view.frame.origin.y -= (bottomButtonBaseline - keyboardY)
                }
            }
        }
    }
    
    @objc
    func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    //MARK: - Setup UI 
    private func addSubviews() {
        [
            mainLabel,
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            forgotPasswordButton,
            signInButton,
            errorInput,
            dontHaveAnAccountLabel,
            signUpButton
        ]
        .forEach(view.addSubview)
    }
    
    private func setupConstraints() {
        mainLabel.autoPinEdge(toSuperviewMargin: .top, withInset: 130)
        mainLabel.autoPinEdge(toSuperviewMargin: .leading)
        
        emailLabel.autoPinEdge(.top, to: .bottom, of: mainLabel, withOffset: 24)
        emailTextField.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 8)
        let heightEmail = emailTextField.heightAnchor.constraint(equalToConstant: 40)
        
        
        passwordLabel.autoPinEdge(.top, to: .bottom, of: emailTextField, withOffset: 24)
        passwordTextField.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: 8)
        let heightPassword = passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        
        errorInput.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 12)
        errorInput.autoPinEdge(toSuperviewMargin: .leading)
        
        forgotPasswordButton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 12)
        forgotPasswordButton.autoPinEdge(toSuperviewMargin: .trailing)
        
        signInButton.autoPinEdge(.top, to: .bottom, of: forgotPasswordButton, withOffset: 24)
        
        dontHaveAnAccountLabel.autoPinEdge(toSuperviewMargin: .leading)
        dontHaveAnAccountLabel.autoPinEdge(.top, to: .bottom, of: signInButton, withOffset: 24)
        
        signUpButton.autoPinEdge(.leading, to: .trailing, of: dontHaveAnAccountLabel, withOffset: 4)
        signUpButton.autoAlignAxis(.horizontal, toSameAxisOf: dontHaveAnAccountLabel)
        
        [
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            signInButton
        ]
        .forEach {
            $0.autoPinEdge(toSuperviewMargin: .leading)
            $0.autoPinEdge(toSuperviewMargin: .trailing)
        }
        NSLayoutConstraint.activate([heightEmail, heightPassword])
    }
    
    private func makeLabel(title: String) -> UILabel {
        let label = UILabel.newAutoLayout()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }
}
