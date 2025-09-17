//
//  TabbableViewContrller.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/8/21.
//

import Foundation
import UIKit

class TabbableViewController: UIViewController {
    private lazy var menuBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(named: "hamburger-icon"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(menuBarButtonAction))
        barButton.tintColor = .white
        return barButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupNavigationBar()
        addBackgroundImage()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc func menuBarButtonAction() {
        
    }
    
}
