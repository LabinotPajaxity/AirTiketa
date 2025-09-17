//
//  PaymentSuccesController.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 16.9.21..
//

import Foundation
import UIKit
import WebKit

class PaymentInWebView: UIViewController,WKUIDelegate {
    
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var responseUrl = [PaymentResponse]()
    var reservationid: String = ""
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            setupUI()
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)

       
        let myURL = URL(string: (responseUrl.first?.proceedOrderUrl)!)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
    
    // Add observer

    // Observe value
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = change?[.newKey] as? URL else { return }
        let absoluteURL = key.absoluteString
        
        print("Navigated to: \(absoluteURL)")

        // kontrollo per success url
        if absoluteURL.contains("payment-success") {
//            let reservationId = getQueryStringParameter(url: absoluteURL, param: "reservationId") ?? ""
            let reservationId = getQueryStringParameter(url: absoluteURL, param: "reservationId")
                ?? getQueryStringParameter(url: absoluteURL, param: "session_id")
                ?? ""

            let storyboard = UIStoryboard(name: "SuccesPaymentStoryboard", bundle: nil)
            let profileVC = storyboard.instantiateViewController(identifier: "SuccesPaymentViewController") as! SuccesPaymentViewController
            profileVC.idBooking = reservationId
            navigationController?.pushViewController(profileVC, animated: true)
        }
        else if absoluteURL.contains("payment-fail") {
            CanceledPaymentDirection()
        }
    }

    private func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }

    func setupUI() {
            self.view.backgroundColor = .white
            self.view.addSubview(webView)
            
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                webView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                webView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
            ])
        }
    
    private func CanceledPaymentDirection() {
        
        // Load the storyboard containing FailedPaymentViewController
        let storyboard = UIStoryboard(name: "FailedPaymentViewController", bundle: nil)
        
        // Instantiate the failed payment controller
        guard let failedVC = storyboard.instantiateViewController(
            identifier: "FailedPaymentViewController"
        ) as? FailedPaymentViewController else {
            print("FailedPaymentViewController not found!")
            return
        }
        
        // Navigate to failed payment screen
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(failedVC, animated: true)
        }
    }

    
}

