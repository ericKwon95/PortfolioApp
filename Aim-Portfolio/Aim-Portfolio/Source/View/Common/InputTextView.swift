//
//  InputTextView.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/11/24.
//

import SwiftUI

struct InputTextView: View {
    @Binding var text: String
    
    let description: String
    let isValid: Bool
    let isVisible: Bool
    let title: String
    let placeholder: String
    let isSecure: Bool
    let keyboardType: UIKeyboardType
    let interval: CGFloat
    
    let onSubmit: () -> Void
    let onChange: (String) -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            HStack{
                Text(title)
                    .foregroundStyle(.appPrimary)
                    .font(.system(size: 14))
                Spacer()
            }
            HStack {
                if isSecure {
                    SecureTextFieldRepresentable(
                        placeholder: placeholder,
                        text: $text,
                        onChange: { newText in
                            onChange(newText)
                        },
                        onSubmit: {
                            onSubmit()
                        }
                    )
                    .warning(interval)
                } else{
                    TextField(placeholder, text: $text, prompt: Text(placeholder).foregroundColor(.gray.opacity(0.7)), axis: .vertical)
                        .foregroundStyle(.black)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                        .warning(interval)
                        .onChange(of: text) {newValue in
                            guard newValue.contains("\n") else {
                                onChange(newValue)
                                return
                            }
                            text = newValue.replacing("\n", with: "")
                            onSubmit()
                        }
                }
                checkMarkImage
                    .opacity(isValid ? 1 : 0)
            }
            divider
            HStack {
                Text(description)
                    .font(.system(size: 12))
                    .foregroundStyle(.red)
                    .opacity(isVisible ? 1 : 0)
                Spacer()
            }
        }
    }
    
    private var checkMarkImage: some View {
        Image(systemName: "checkmark")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.appPrimary)
            .frame(width: 20, height: 20)
    }
    
    private var divider: some View {
        Rectangle()
            .frame(height: 1)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.appPrimary)
    }
}

fileprivate
extension View {
    func warning(_ interval: CGFloat) -> some View {
        self.modifier(WarningEffect(interval))
            .animation(Animation.default, value: interval)
    }
}

fileprivate
struct WarningEffect: GeometryEffect {
    
    var animatableData: CGFloat
    var amount: CGFloat = 3
    var shakeCount = 6

    init(_ interval: CGFloat) {
        self.animatableData = interval
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * CGFloat(shakeCount) * .pi), y: 0))
    }
}
