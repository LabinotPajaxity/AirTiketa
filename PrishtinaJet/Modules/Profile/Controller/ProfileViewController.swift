//
//  ProfileViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 12.8.21..
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var fullNameUser: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var passwordTextField: UILabel!
    @IBOutlet weak var phoneTextField: UILabel!
    @IBOutlet weak var birthdayTextField: UILabel!
    @IBOutlet weak var genderTextField: UILabel!
    @IBOutlet weak var cityTextField: UILabel!
    @IBOutlet weak var countryTextField: UILabel!
    
    var userModel = [User]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllData()
        
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        // Do any additional setup after loading the view.
        view.backgroundColor = AppColors.lightBlue
    }
    
    private func setupNavigation() {
        let barAppearance = UINavigationBarAppearance()

            barAppearance.backgroundColor = AppColors.lightBlue
            barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
            extendedLayoutIncludesOpaqueBars = true
    }
    
    func getAllData() {
        GetUserInfo().perform { [weak self] result in
                  switch result {
                  case .success(let user):
                      self?.userModel = []
                      self?.fullNameUser.text = user.fullName
                      self?.emailTextField.text = user.email
                      self?.phoneTextField.text = user.phoneNumber
                      self?.birthdayTextField.text = user.dateOfBirth
                      self?.genderTextField.text = user.gender
                      self?.cityTextField.text = user.city
                      self?.countryTextField.text = user.country
      
                  case .failure(let error):
                      print(error)
      //                self?.delegate?.didGetFailure()
                }
        }
    }
    
    @IBAction func editActionPencil(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EditPorfile", bundle: nil)
        let editProfileVC = storyboard.instantiateViewController(identifier: "EditProfileViewController")
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    

}
