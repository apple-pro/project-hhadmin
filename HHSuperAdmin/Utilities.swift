//
//  Utilities.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import Foundation

class Config {
    
    static func get(_ key: String) -> String {
        UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    static func set(key: String, _ value: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
}
