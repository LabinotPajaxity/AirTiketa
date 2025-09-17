//
//  Testt.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 11.10.22..
//

import Foundation
import UIKit

extension UIViewController {
    func updateUserInterface() {
        guard let reachability = Network.reachability else {
            print("Reachability not available")
            return
        }

        switch reachability.status {
        case .unreachable:
            PopUpActionViewController.showPopup(parentVC: self)
        case .wwan:
            print("wwan")
        case .wifi:
            self.dismiss(animated: true)
        }
    }

    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    @objc
       func tapFunction(sender:UITapGestureRecognizer) {
           let storyboard = UIStoryboard(name: "TermsAndCondition", bundle: nil)
           let TermsAndConditions = storyboard.instantiateViewController(identifier: "TermsAndConditions")
           self.present(TermsAndConditions, animated: true)
           
       }
    
    @objc
       func tapPrivacyPolicy(sender:UITapGestureRecognizer) {
           let storyboard = UIStoryboard(name: "PrivacyPolicy", bundle: nil)
           let TermsAndConditions = storyboard.instantiateViewController(identifier: "PrivacyPolicy")
           self.present(TermsAndConditions, animated: true)
           
       }
}
