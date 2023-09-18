//
//  CustomTextField.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI
enum keyboardTypeEnum {
    case email
    case name
    case num
    case scale
}
struct CustomTextField: View {
    var customKeyboardChoice : keyboardTypeEnum
    private var keyboardContentType: UITextContentType {
        switch customKeyboardChoice {
        case .email:
            return .emailAddress
        case .num:
            return .telephoneNumber
        case .name:
            return .username
        case .scale:
            return .telephoneNumber
        }
        
    }
    private var keyboardType: UIKeyboardType {
        switch customKeyboardChoice {
        case .email:
            return .emailAddress
        case .num:
            return .numberPad
        case .scale:
            return .decimalPad
        case .name:
            return .default
        }
    }
    
    var hint: String
    @Binding var text: String
    
    //MARK: ViewProperties
    @FocusState var isEnabled: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(hint)
                        .font(.custom("Lato-Regular", size: 13).weight(.light))
                        .foregroundColor(.gray)
                }
                .keyboardType(keyboardType)
                .textContentType(keyboardContentType)
                .focused($isEnabled)
                .padding(.top,10)
            
                
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.primary.opacity(0.2))
                Rectangle()
                    .fill(Color(red: 0.3, green: 0.71, blue: 0.74))
                    .frame(width: isEnabled ? nil : 0, alignment: .leading)
                    .animation(.easeInOut(duration: 0.3), value: isEnabled)
            }
            .frame(height: 2)
        }
    }
}

//struct CustomTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextField()
//    }
//}
