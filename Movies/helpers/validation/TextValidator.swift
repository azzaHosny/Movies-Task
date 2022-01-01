//
//  TextValidator.swift
//  Created by azah on 12/30/21.


import UIKit

protocol Validator {
    func isValid(text: String?, regex: ValidationType) -> LoginScreenStatus
    func validate(email: String?, password: String?) -> LoginScreenStatus
}

class TextValidator: Validator {
    
    func isValid(text: String?, regex: ValidationType) -> LoginScreenStatus {
        guard let textValue = text else { return .notValid(errorMsg: ["Empty"]) }
        if textValue.matches(regex.regex) {
            return .valid
        } else {
            return .notValid(errorMsg: [regex.errorMsg])
        }
    }
    
    func validate(email: String?, password: String?) -> LoginScreenStatus {

        if case .valid = isValid(text: email, regex: TextValidationType.email) , case .valid = isValid(text: password, regex: TextValidationType.password) {
            return .valid
        } else {
            var errors: [String] = []
            if case .notValid(let error) = isValid(text: email, regex: TextValidationType.email) {
                errors.append(contentsOf: error)
            }
            if case .notValid(let error) = isValid(text: password, regex: TextValidationType.password) {
                errors.append(contentsOf: error)
            }
            return .notValid(errorMsg: errors)
        }
    }
   
}


