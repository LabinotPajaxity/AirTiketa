//
//  UserDefaults-Ext.swift
//  Athlogic
//
//  Created by Pajaziti Labinot on 12.6.22..
//

import Foundation

enum UserDefaultsKeys : String {
    case paymentType
    case contactNumber
    case countOfPassanger
}

extension UserDefaults{

    //MARK: Save User Data
    func setPaymentType(value: String){
        set(value, forKey: UserDefaultsKeys.paymentType.rawValue)
        //synchronize()
    }
    
    func setcontactNumber(value: String){
        set(value, forKey: UserDefaultsKeys.contactNumber.rawValue)
    }
    

    //MARK: Retrieve User Data
    func getPaymentType() -> String{
        return string(forKey: UserDefaultsKeys.paymentType.rawValue) ?? ""
    }
    
    //MARK: Save User Data
       func setCountOfPassanger(value: Int){
           set(value, forKey: UserDefaultsKeys.countOfPassanger.rawValue)
           //synchronize()
       }

       //MARK: Retrieve User Data
       func getCountOfPassanger() -> Int{
           return integer(forKey: UserDefaultsKeys.countOfPassanger.rawValue)
       }
    
    func getcontactNumber() -> String {
        return string(forKey: UserDefaultsKeys.contactNumber.rawValue) ?? ""
    }
    
}
