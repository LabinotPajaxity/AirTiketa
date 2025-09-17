//
//  NotConnectedVC.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 10.10.22..
//

import UIKit
import Lottie

class NotConnectedVC: UIViewController {

    @IBOutlet weak var AnimationView: LottieAnimationView!
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
//          setupAnimationView()
      }
      
      private func setupAnimationView() {
          guard let AnimationView = AnimationView else {
              print("animationView is nil")
              return
          }

          AnimationView.contentMode = .scaleAspectFill
//          AnimationView.loopMode = .loop
          AnimationView.play()
      }
    

    
}
