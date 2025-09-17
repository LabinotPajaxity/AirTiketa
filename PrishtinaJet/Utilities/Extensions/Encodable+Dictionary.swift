//
//  Encodable+Dictionary.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 4/1/21.
//

import Foundation

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    
    var queryParams: String? {
        return "?" + dictionary
            .compactMap { key, value -> String? in
                return "\(key)=\(value)"
            }
            .joined(separator: "&")
    }
}
