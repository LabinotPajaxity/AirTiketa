//
//  DateHelper.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 16.4.21.
//

import Foundation

class DateHelper {
    class func getDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        return date
    }
    
    class func formatDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    class func getDuration(departure: String, arrival: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        guard let departureDate = dateFormatter.date(from: departure),
              let arrivalDate = dateFormatter.date(from: arrival) else {
            return ""
        }
        let diffComponents = Calendar.current.dateComponents([.hour, .minute,],
                                                             from: departureDate,
                                                             to: arrivalDate)
        guard let hours = diffComponents.hour,
              let minutes = diffComponents.minute else {
            return ""
        }
        
        if hours == 0 {
            return "\(minutes) min"
        }
        if minutes == 0 {
            return "\(hours) h"
        }
        return "\(hours)h \(minutes) min"
    }
}
