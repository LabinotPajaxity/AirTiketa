//
//  ChangePasswordViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 17.8.21..
//

import UIKit
import Alamofire
import Toast

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPasswordTextField: InputTextField!
    @IBOutlet weak var newPasswordTextField: InputTextField!
    @IBOutlet weak var confirmNewPasswordTF: InputTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = AppColors.lightBlue
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        if  (oldPasswordTextField.text?.isEmpty)! ||
            (newPasswordTextField.text?.isEmpty)! ||
                (confirmNewPasswordTF.text?.isEmpty)!
             {
            showErrorAlert(message: "All fields are required to fill in")
            
            oldPasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
            newPasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
            confirmNewPasswordTF.layer.borderColor = UIColor.systemRed.cgColor
            
            return
        }
        if oldPasswordTextField.text == newPasswordTextField.text {
            showErrorAlert(message: "The old password does not have to be the same as the new password")
            return
        }
        if ((newPasswordTextField.text?.elementsEqual(confirmNewPasswordTF.text!)) != true)
        {
            // Display Alert message and return
            showErrorAlert(message: "New Password not equal")
        return
        }
        postMethod()
    }
    
    func postMethod() {
        ChangePassword(oldPassword: oldPasswordTextField.text!, newPassword: newPasswordTextField.text!).perform { result in
            switch result {
            case .success:
                self.view.makeToast("The password changed successfully.", duration: 3.0, position: .bottom){ didTap in
                    if didTap {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            case .failure( let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    

    @IBAction func CancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
