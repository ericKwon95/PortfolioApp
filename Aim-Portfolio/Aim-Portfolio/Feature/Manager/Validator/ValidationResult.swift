//
//  ValidationResult.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

enum ValidationResult {
    enum ID {
        case valid
        case tooShort
        case tooLong
        case invalidCharacter
        
        var description: String {
            switch self {
            case .valid:
                return "사용할 수 있는 아이디 입니다."
            case .tooShort:
                return "아이디는 7자 이상이어야 합니다."
            case .tooLong:
                return "아이디는 20자를 넘을 수 없습니다."
            case .invalidCharacter:
                return "아이디는 영문자만 포함할 수 있습니다."
            }
        }
    }
    
    enum Password {
        case valid
        case tooShort
        case tooLong
        case invalidCharacter
        
        var description: String {
            switch self {
            case .valid:
                return "사용할 수 있는 비밀번호 입니다."
            case .tooShort:
                return "비밀번호는 10자 이상이어야 합니다."
            case .tooLong:
                return "비밀번호가 너무 깁니다."
            case .invalidCharacter:
                return "비밀번호는 영문, 숫자, 특수문자를 각각 하나 이상 포함해야 합니다."
            }
        }
    }
    
    enum PhoneNumber {
        case valid
        case invalid
        
        var description: String {
            switch self {
            case .valid:
                return "올바른 번호 형식 입니다."
            case .invalid:
                return "잘못된 전화번호 형식 입니다."
            }
        }
    }
    
    enum Email {
        case valid
        case invalid
        
        var description: String {
            switch self {
            case .valid:
                return "올바른 이메일 형식 입니다."
            case .invalid:
                return "잘못된 이메일 형식 입니다."
            }
        }
    }
}
