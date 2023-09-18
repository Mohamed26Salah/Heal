//
//  SecureTextField.swift
//  Heal
//
//  Created by Mohamed Salah on 19/09/2023.
//

import SwiftUI

struct SecureTextFieldCustom: View {
    var hint: String
    @Binding var text: String
    
    //MARK: ViewProperties
    @FocusState var isEnabled: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            SecureField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(hint)
                        .font(.custom("Lato-Regular", size: 13).weight(.light))
                        .foregroundColor(.gray)
                }
                .keyboardType(.default)
                .textContentType(.password)
                .focused($isEnabled)
            
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
