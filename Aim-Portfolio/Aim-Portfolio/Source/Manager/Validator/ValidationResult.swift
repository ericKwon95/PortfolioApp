//
//  ValidationResult.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

protocol ValidationResultable: Equatable {
    var description: String { get }
    var isValid: Bool { get }
}

enum ValidationResult {
    enum ID: ValidationResultable {
        case valid
        case tooShort
        case tooLong
        case invalidCharacter
        case empty
        
        var description: String {
            switch self {
            case .valid:
                return " "
            case .tooShort:
                return "아이디는 7자 이상이어야 합니다."
            case .tooLong:
                return "아이디는 20자를 넘을 수 없습니다."
            case .invalidCharacter:
                return "아이디는 영문자만 포함할 수 있습니다."
            case .empty:
                return "아이디가 비어있습니다."
            }
        }
        
        var isValid: Bool {
            return self == .valid
        }
    }
    
    enum Password: ValidationResultable {
        case valid
        case tooShort
        case tooLong
        case invalidCharacter
        case empty
        
        var description: String {
            switch self {
            case .valid:
                return " "
            case .tooShort:
                return "비밀번호는 10자 이상이어야 합니다."
            case .tooLong:
                return "비밀번호가 너무 깁니다."
            case .invalidCharacter:
                return "비밀번호는 영문, 숫자, 특수문자를 각각 하나 이상 포함해야 합니다."
            case .empty:
                return "비밀번호가 비어있습니다."
            }
        }
        
        var isValid: Bool {
            return self == .valid
        }
    }
    
    enum PhoneNumber: ValidationResultable {
        case valid
        case invalid
        case empty
        
        var description: String {
            switch self {
            case .valid:
                return " "
            case .invalid:
                return "잘못된 전화번호 형식 입니다."
            case .empty:
                return "전화번호가 비어있습니다."
            }
        }
        
        var isValid: Bool {
            return self == .valid
        }
    }
    
    enum Email: ValidationResultable {
        case valid
        case invalid
        case empty
        
        var description: String {
            switch self {
            case .valid:
                return " "
            case .invalid:
                return "잘못된 이메일 형식 입니다."
            case .empty:
                return "이메일이 비어있습니다."
            }
        }
        
        var isValid: Bool {
            return self == .valid
        }
    }
}
