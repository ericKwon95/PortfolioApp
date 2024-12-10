//
//  Validator.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

import Foundation

struct Validator {
    static func validateID(_ id: String) -> ValidationResult.ID {
        guard id.count >= 7 else {
            return .tooShort
        }
        
        guard id.count <= 20 else {
            return .tooLong
        }
        
        let alphabets = /[A-Za-z]+/
        guard id.wholeMatch(of: alphabets) != nil else {
            return .invalidCharacter
        }
        
        return .valid
    }
    
    static func validatePassword(_ password: String) -> ValidationResult.Password {
        guard password.count >= 10 else {
            return .tooShort
        }
        
        guard password.count <= 100 else {
            return .tooLong
        }
        
        let alphabetNumberSpecialCharacters = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:\'"\\|,.<>\/?])[\w!@#$%^&*()_+\-=\[\]{};:\'"\\|,.<>\/?]+$/
        guard password.wholeMatch(of: alphabetNumberSpecialCharacters) != nil else {
            return .invalidCharacter
        }
        
        return .valid
    }
    
    static func validatePhoneNumber(_ phoneNumber: String) -> ValidationResult.PhoneNumber {
        let phoneNumberRegex = /^010[0-9]{8}$/
        guard phoneNumber.wholeMatch(of: phoneNumberRegex) != nil else {
            return .invalid
        }
        
        return .valid
    }
    
    static func validateEmail(_ email: String) -> ValidationResult.Email {
        let emailRegex = /^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$/
        guard email.wholeMatch(of: emailRegex) != nil else {
            return .invalid
        }
        return .valid
    }
}
