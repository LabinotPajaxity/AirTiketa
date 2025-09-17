//
//  SideMenuItem.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/12/21.
//

import Foundation

struct SideMenuItem {
    let iconName: String
    let title: String
}

extension SideMenuItem {
    static func dataSource() -> [SideMenuItem] {
        if KeychainManager.shared.isLoggedIn() == true {
            return [
                
                SideMenuItem(iconName: "home", title: "Home"),
                SideMenuItem(iconName: "bookings", title: "Bookings"),
                SideMenuItem(iconName: "profile", title: "Profile"),
                SideMenuItem(iconName: "profile", title: "Logout"),
            ]
        } else {
            return [
                
                SideMenuItem(iconName: "home", title: "Home"),
                SideMenuItem(iconName: "profile", title: "Login"),
            ]
        }
        
    }
}
