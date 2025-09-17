//
//  EditProfileViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 13.8.21..
//

import UIKit
import Toast

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var birthdayTextField: InputTextField!
    @IBOutlet weak var genderTextField: InputTextField!
    @IBOutlet weak var cityTextField: InputTextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    var fullName: String?
    var email: String?
    var phoneNumber: String?
    var dateOfBirth: String?
    var gender: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var address: String?
    
    var selectedGender: String?
    var user = [User]()
    var initialUser = [User]()
    var userFromApi: User?
//    var user2 : User?
//    var delegateFromSomethingChangeProtocol: FormSomethingChangeProtocol?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllData()
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllLogicData()
        view.backgroundColor = AppColors.lightBlue
        
        emailTextField.isUserInteractionEnabled = false

        let datePickerView = UIDatePicker()
            datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
                
        setupKeyboardTypeForFields()
        saveButtonOutlet.isEnabled = false
        birthdayTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
//        fullNameTextField.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
//        emailTextField.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
//        phoneNumberTextField.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
//        countryTextField.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
//        birthdayTextField.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
//        genderTextField.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
//        cityTextField.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
//        zipCodeTextField.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
//        addressTextField.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        [fullNameTextField, emailTextField, phoneNumberTextField, countryTextField, birthdayTextField, genderTextField, cityTextField, zipCodeTextField, addressTextField].forEach({ $0.addTarget(self, action: #selector(EditProfileViewController.textFieldDidChange(_:)), for: .editingChanged)})
//        delegateFromSomethingChangeProtocol = FormSomethingChange(button: saveButtonOutlet, objectWhenDidChange: user, textFieldInView: [emailTextField, phoneNumberTextField, birthdayTextField, genderTextField, cityTextField, zipCodeTextField, countryTextField, addressTextField], objectFromApi: initialUser, handler: onSubmit) as? any FormSomethingChangeProtocol
    }
    private func setupKeyboardTypeForFields() {
        fullNameTextField.keyboardType = .default
        addressTextField.keyboardType = .asciiCapable
        cityTextField.keyboardType = .default
        zipCodeTextField.keyboardType = .asciiCapableNumberPad
    }
    
    private func setupAllLogicData(){
        createPickerView()
        setupDesign()
        setupNavigation()
    }
    
    private func setupNavigation() {
        let barAppearance = UINavigationBarAppearance()

            barAppearance.backgroundColor = AppColors.lightBlue
            barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
            extendedLayoutIncludesOpaqueBars = true
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                birthdayTextField.text = dateFormatter.string(from: sender.date)
            }
    
    
    func getAllData() {
        GetUserInfo().perform { [weak self] result in
            switch result {
            case .success(let user):
                self?.userFromApi = user
                self?.setDataToTextFields(user: user)
                self?.setInitialData(user: user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupDesign() {
        changePasswordButton.layer.borderWidth = 1
        changePasswordButton.layer.borderColor = AppColors.lightBlue.cgColor
        changePasswordButton.layer.cornerRadius = 10
    }
    
//    @IBAction func SaveDataChange(_ sender: Any) {
//        EditUserApiPut.instance.editProfile(fullName: fullNameTextField.text!, email: emailTextField.text!, phoneNumber: phoneNumberTextField.text!, address: addressTextField.text!, city: cityTextField.text!, zipCode: zipCodeTextField.text!, country: countryTextField.text!, gender: genderTextField.text!, dateOfBirth: birthdayTextField.text!) { success, user in
//            if success {
//                self.view.makeToast("All changes have been saved.", duration: 3.0, position: .bottom){ didTap in
//                    if didTap {
//                        self.navigationController?.popViewController(animated: true)
//                    } else {
//                        self.navigationController?.popViewController(animated: true)
//                    }
//                }
//            } else {
//                self.view.makeToast("Something went wrong please try again later.", duration: 3.0, position: .top)
//            }
//        }
//    }
    private func onSubmit() {
        print("✅")
    }
    
    @IBAction func ChangePasswordAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ChangePassword", bundle: nil)
        let editProfileVC = storyboard.instantiateViewController(identifier: "ChangePasswordViewController")
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setDataToTextFields(user: User) -> Void {
        self.user = []
        self.fullNameTextField.text = user.fullName
        self.emailTextField.text = user.email
        self.phoneNumberTextField.text = user.phoneNumber
        self.birthdayTextField.text = user.dateOfBirth
        self.genderTextField.text = user.gender
        self.cityTextField.text = user.city
        self.zipCodeTextField.text = user.zipCode
        self.countryTextField.text = user.country
        self.addressTextField.text = user.address
    }
    
    func setInitialData(user: User) -> Void {
        self.fullName = user.fullName
        self.email = user.email
        self.phoneNumber = user.phoneNumber
        self.dateOfBirth = user.dateOfBirth
        self.gender = user.gender
        self.city = user.city
        self.zipCode = user.zipCode
        self.country = user.country
        self.address = user.address
    }
    
    func isTextFieldsDataEqualToInitialData() -> Bool {
        if self.fullNameTextField.text == self.fullName &&
           self.emailTextField.text == self.email &&
           self.phoneNumberTextField.text == self.phoneNumber &&
           self.birthdayTextField.text == self.dateOfBirth &&
           self.genderTextField.text == self.gender &&
           self.cityTextField.text == self.city &&
           self.zipCodeTextField.text == self.zipCode &&
           self.countryTextField.text == self.country &&
           self.addressTextField.text == self.address {
            self.saveButtonOutlet.backgroundColor = UIColor.lightGray
           return true
       } else {
        self.saveButtonOutlet.backgroundColor = AppColors.lightBlue
           return false
       }
    }
    
}
extension EditProfileViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        
//        if(self.isTextFieldsDataEqualToInitialData()) {
//
//            saveButtonOutlet.isEnabled = false
//        } else {
//            saveButtonOutlet.isEnabled = true
//        }
        
//        let user = User(fullName: fullNameTextField.text, email: emailTextField.text, phoneNumber: phoneNumberTextField.text, address: addressTextField.text, city: cityTextField.text, zipCode: zipCodeTextField.text, country: countryTextField.text, gender: genderTextField.text, dateOfBirth: birthdayTextField.text)
//        delegateFromSomethingChangeProtocol = FormSomethingChange(button: saveButtonOutlet, objectWhenDidChange: user, textFieldInView: [emailTextField, phoneNumberTextField, birthdayTextField, genderTextField, cityTextField, zipCodeTextField, countryTextField, addressTextField], objectFromApi: userFromApi as Any, handler: onSubmit)
//        
        
    }
}



extension EditProfileViewController:  UIPickerViewDelegate, UIPickerViewDataSource{
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
            if(self.isTextFieldsDataEqualToInitialData()) {
                saveButtonOutlet.isEnabled = false
            } else {
                saveButtonOutlet.isEnabled = true
            }
        }
        
        func createPickerView() {
            let pickerView = UIPickerView()
            pickerView.delegate = self
            genderTextField.inputView = pickerView
        }
}




