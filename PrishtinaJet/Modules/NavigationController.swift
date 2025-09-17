//
//  NavigationController.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/9/21.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                             .font: UIFont.boldSystemFont(ofSize: 22)]
        navigationBar.tintColor = .white
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                          style: .plain,
                                                                          target: nil,
                                                                          action: nil)
        super.pushViewController(viewController, animated: true)
    }
}
