//
//  TextValidationType.swift
//  Created by azah on 12/30/21.

import Foundation

protocol ValidationType {
    var regex: String {get }
    var errorMsg: String { get }
}
enum TextValidationType: String, ValidationType {
    
    case email = "[A-Z0-9a-zA-Za-zء-ي٠-٩._%+-]+@[A-Za-z0-9A-Za-zء-ي٠-٩.-]+\\.[A-Za-zA-Za-zء-ي٠-٩]{2,4}"
    case password = "[A-Za-zA-Za-zء-ي٠-٩]{8,15}$"
    
    var regex: String {
        return self.rawValue
    }
    
    var errorMsg: String {
        switch self {
            case .email: return "Email is not valid"
            case .password: return "Password size must be between 8 - 15 characters"
        }
    }
}
