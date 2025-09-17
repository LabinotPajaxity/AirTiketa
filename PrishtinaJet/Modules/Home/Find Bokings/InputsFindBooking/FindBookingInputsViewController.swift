//
//  FindBookingInputsViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 17.10.21..
//

import UIKit

class FindBookingInputsViewController: UIViewController {
    @IBOutlet weak var lastNameOutlet: UITextField!
    @IBOutlet weak var confirmationOutlet: UITextField!
    
    @IBOutlet weak var newSearchButtonOutlet: UIButton!
    @IBOutlet weak var searchButtonoutlet: UIButton!
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           confirmationOutlet.delegate = self
           configureButtons()
       }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }


       
       private func configureButtons() {
           // Search button: red background, white text
           searchButtonoutlet.backgroundColor = AppColors.newRedColorForALL
           searchButtonoutlet.setTitleColor(.white, for: .normal)
           searchButtonoutlet.layer.cornerRadius = 8
           searchButtonoutlet.clipsToBounds = true
           
           // New search button: no background, red text, red border
           newSearchButtonOutlet.backgroundColor = .clear
           newSearchButtonOutlet.setTitleColor(AppColors.newRedColorForALL, for: .normal)
           newSearchButtonOutlet.layer.borderWidth = 1.5
           newSearchButtonOutlet.layer.borderColor = AppColors.newRedColorForALL.cgColor
           newSearchButtonOutlet.layer.cornerRadius = 8
           newSearchButtonOutlet.clipsToBounds = true
       }
    
    @IBAction func SearchButtonAction(_ sender: Any) {
        
        if  (lastNameOutlet.text?.isEmpty)! ||
            (confirmationOutlet.text?.isEmpty)! {
            showErrorAlert(message: "Fields are quired to fill in")
        } else {
            let storyboard = UIStoryboard(name: "FinderBookingStoryboard", bundle: nil)
            let profileVC = storyboard.instantiateViewController(identifier: "FindMyBookingController") as! FindMyBookingController
            profileVC.confirmationCode = confirmationOutlet.text!
            profileVC.lastName = lastNameOutlet.text!
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    @IBAction func NewSearchAction(_ sender: Any) {
        lastNameOutlet.text = ""
        confirmationOutlet.text = ""
    }
}

// Restrict UITextField to take only numbers in Swift?
extension FindBookingInputsViewController: UITextFieldDelegate {
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == confirmationOutlet {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
