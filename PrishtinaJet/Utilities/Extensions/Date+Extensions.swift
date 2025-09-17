//
//  Date+Extensions.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/26/21.
//

import Foundation

extension Date {
    var numberOfDaysInMonth: Int {
        let range = Calendar.current.range(of: .day, in: .month, for: self)
        return range?.count ?? 0
    }
    
    var firstDayWeekday: Int {
        guard let firstDayOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else {
            fatalError("Cannot get date components")
        }
        let weekday = Calendar.current.component(.weekday, from: firstDayOfMonth)
        return weekday
    }
    
    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func addedBy(month: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: month, to: self)
    }
}
