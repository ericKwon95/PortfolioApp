//
//  SecureTextFieldRepresentable.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/11/24.
//

import SwiftUI

struct SecureTextFieldRepresentable: UIViewRepresentable {
    private let placeholder: String
    @Binding var text: String
    let onChange: (String) -> Void
    let onSubmit: () -> Void
    
    init(placeholder: String, text: Binding<String>, onChange: @escaping (String) -> Void, onSubmit: @escaping () -> Void) {
        self.placeholder = placeholder
        self._text = text
        self.onChange = onChange
        self.onSubmit = onSubmit
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.text = text
        textField.isSecureTextEntry = true
        textField.keyboardType = .asciiCapable
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            text: $text,
            onChange: onChange,
            onReturn: onSubmit
        )
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        let onChange: (String) -> Void
        let onReturn: () -> Void
        
        init(text: Binding<String>, onChange: @escaping (String) -> Void, onReturn: @escaping () -> Void) {
            self._text = text
            self.onChange = onChange
            self.onReturn = onReturn
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onReturn()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text, let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                onChange(updatedText)
            }
            return true
        }
    }
}

@available(iOS 17, *)
#Preview {
    @Previewable @State var text: String = ""
    SecureTextFieldRepresentable(
        placeholder: "placeholder",
        text: $text,
        onChange: { string in
            
        },
        onSubmit: {}
    )
}
