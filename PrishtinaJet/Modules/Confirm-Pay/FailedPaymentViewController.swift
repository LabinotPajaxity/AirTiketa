//
//  FailedPaymentViewController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 16.9.21..
//

import UIKit

class FailedPaymentViewController: UIViewController {
    @IBOutlet weak var ShadowView: UIView!
    @IBOutlet weak var retryButtonOutlet: UIButton!
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        shadowVeiw()
        retryButtonOutlet.layer.cornerRadius = 10
    }
    
    private func setupNavigation() {
        navigationItem.title = "Error"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.newRedColorForALL // Use your red color
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.isTranslucent = false

        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .done,
            target: self,
            action: #selector(addAction)
        )
        addButton.tintColor = AppColors.almostWhite
        navigationItem.leftBarButtonItem = addButton
    }

    
    @objc private func addAction() {
//        self.popBack(3)
        self.navigationController?.popToRootViewController(animated: true)

    }

    @IBAction func retryButtonTapped(_ sender: Any) {
        self.popBack(3)
    }
    
    func shadowVeiw(){
        ShadowView.layer.cornerRadius = 10
        ShadowView.layer.shadowRadius = 5
        ShadowView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        ShadowView.layer.shadowOpacity = 0.8
        ShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        ShadowView.layer.backgroundColor = UIColor.white.cgColor
        ShadowView.layer.masksToBounds = false
    }
    
    /// pop back n viewcontroller
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
}
