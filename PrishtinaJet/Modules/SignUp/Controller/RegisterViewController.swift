//
//  RegisterViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 11.8.21..
//

import UIKit
//import FormValidation

class RegisterViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var confirmPhoneTextField: UITextField!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var dateOfBirthday: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var countryField: UITextField!
    
    var selectedCountry: Country?
    var selectedGender: String?
    var countries = [Country]()
    
    var formValidationDelegate: FormValidationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardTypeForFields()
        let datePickerView = UIDatePicker()
            datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        dateOfBirthday.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        countryField.addTarget(self, action: #selector(textDidBeginEditing), for: UIControl.Event.editingDidBegin)
        countryField.inputView = UIView()

        view.addGestureRecognizer(tap)
        setupNavigationBar()
        pickGender()
        dismissPickerView()
        
        
        formValidationDelegate = FormValidation(button: signUpButton, fields: [
            fullNameTextField, phoneTextField, confirmPhoneTextField,
            streetTextField, cityTextField, zipCodeTextField,
            genderTextField, dateOfBirthday,emailTextField,countryField,
            passwordTextField, confirmPasswordTextField
        ],
            handler: onSubmit)
    }
    
   @objc func textDidBeginEditing(sender:UITextField) -> Void
    {
        let countriesVC = CountriesViewController()
        countriesVC.delegate = self
        present(countriesVC, animated: true, completion: nil)
    }
    private func setupKeyboardTypeForFields() {
        fullNameTextField.keyboardType = .default
        streetTextField.keyboardType = .asciiCapable
        cityTextField.keyboardType = .default
        zipCodeTextField.keyboardType = .asciiCapableNumberPad
    }
    
    private func setupNavigationBar() {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = AppColors.navColor
            barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
            extendedLayoutIncludesOpaqueBars = true
    }
    
    
    @objc func handleDatePicker(sender: UIDatePicker) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd"
        dateOfBirthday.text = dateFormatter.string(from: sender.date)
            }
    
    
    
    @objc private func didTapView() {
        view.endEditing(true)
    }
    private func onSubmit() {
        let model = SignUpModel(
                       fullName: fullNameTextField.text!,
                       email: emailTextField.text!,
                       phoneNumber: phoneTextField.text!,
                       password: passwordTextField.text!,
                       address: streetTextField.text!,
                       city: cityTextField.text!,
                       zipCode: zipCodeTextField.text!,
                       country: countryField.text,
                       gender: genderTextField.text!,
                       dateOfBirth: dateOfBirthday.text!
                   )
        SignUp(model: model).perform { response in
                        switch response {
                        case .success:
                            print("Success ✅")
                            self.navigationController?.popViewController(animated: true)
                            print(model.fullName!)
                        case .failure(let error):
                            print("Error register ❌")
                            print(error.localizedDescription)
                            self.showErrorAlert(message: error.localizedDescription)
                        }
                }
        }
    
    @IBAction func BackToLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
}

extension RegisterViewController: CountriesViewControllerDelegate {
    func didSelect(country: Country) {
        let countryName = country.name
        countryField.text = countryName
        countryField.layer.backgroundColor = UIColor.white.cgColor
        countryField.layer.borderColor = AppColors.lightGray.cgColor
        selectedCountry = country
    }
}

extension RegisterViewController:  UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return genderData.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return genderData[row]
           
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedGender = genderData[row]
            genderTextField.text = selectedGender
        }
        
        func pickGender() {
            let pickerView = UIPickerView()
            pickerView.delegate = self
            genderTextField.inputView = pickerView
        }
    
    func dismissPickerView() {
           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           
           let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
           toolBar.setItems([button], animated: true)
           toolBar.isUserInteractionEnabled = true
//        genderTextField.inputAccessoryView = toolBar
        dateOfBirthday.inputAccessoryView = toolBar
        genderTextField.inputAccessoryView = toolBar
       }
    @objc func action() {
       view.endEditing(true)
    }

}
