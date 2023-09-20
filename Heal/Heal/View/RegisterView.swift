//
//  RegisterView.swift
//  Heal
//
//  Created by Mohamed Salah on 19/09/2023.
//

import SwiftUI

struct RegisterView: View {
//    @State var tempLoginState: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var fullName: String = ""
    @State private var selectedGender: Gender?
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Image("healLogo")
                    HStack(alignment: .top) {
                        VStack {
                            Image("Ellipse 7")
                                .padding(.top, 490)
                        }
                        VStack {
                            Image("Ellipse 5")
                                .padding(.top, -8)
                        }
                        VStack {
                            Image("Ellipse 4")
                                .padding(.top, 0)
                        }
                    }
                    Spacer()
                    
                }
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: nil, height: 550)
                    .background(.ultraThinMaterial)
                    .blur(radius: 5)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal, 27)
                    .padding(.top, 170)
                VStack (alignment: .leading, spacing: 38){
                    Text("Sign Up")
                        .font(.custom("Lato-Bold", size: 30))
                        .foregroundColor(.primary)
                    CustomTextField(customKeyboardChoice: .name, hint: "Full Name", text: $fullName)
                    CustomTextField(customKeyboardChoice: .email, hint: "Email", text: $email)
                        .padding(.top, -10)
                    SecureTextFieldCustom(hint: "Password", text: $password)
                    HStack {
                        Spacer()
                        GenderSelectionView(selectedGender: $selectedGender, gender: .male)
                        Spacer()
                        GenderSelectionView(selectedGender: $selectedGender, gender: .female)
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        HStack(spacing: 0) {
                            Spacer()
                            Text("By Signing up, You’re agree to our ")
                                .font(Font.custom("Lato", size: 12))
                                .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                            Link("Terms & Conditions", destination: URL(string: "https://your-terms-and-conditions-url.com")!)
                                .font(Font.custom("Lato", size: 12))
                                .foregroundColor(Color(red: 0.3, green: 0.71, blue: 0.74))
                            Spacer()
                        }
                        HStack(spacing: 0) {
                            Spacer()
                            Text(" and ")
                                .font(Font.custom("Lato", size: 12))
                                .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                            Link("Privacy Policy", destination: URL(string: "https://your-privacy-policy-url.com")!)
                                .font(Font.custom("Lato", size: 12))
                                .foregroundColor(Color(red: 0.3, green: 0.71, blue: 0.74))
                            Spacer()
                        }
                    }
                    .padding(.top, -18)
                    
                    HStack {
                        Button(action: {
                            Task{
                                try await authViewModel.createUser(withEmail:email, password:password, fullName:fullName, gender: selectedGender ?? .male)
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Sign Up")
                                    .font(.custom("Lato-Regular", size: 25).weight(.medium))
                                    .foregroundColor(.white)
                                    .frame(width: 280, height: 37)
                                    .background(Color(red: 0.3, green: 0.71, blue: 0.74))
                                    .cornerRadius(6)
                                Spacer()
                            }
                            
                        }
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        
                    }
                    .padding(.top, -16)
                    HStack(spacing: 0) {
                        Spacer()
                        Text("Joined us before? ")
                            .font(Font.custom("Lato", size: 12))
                            .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Sign In")
                                .font(Font.custom("Lato", size: 12))
                                .foregroundColor(Color(red: 0.3, green: 0.71, blue: 0.74))
                        }
                        Spacer()
                    }.padding(.top, -30)
                    
                }
                .frame(width: nil)
                .padding(.horizontal, 55)
                .padding(.top,210)
                
                if authViewModel.showLoading {
                    ProgressView()
                        .tint(Color.mint)
                        .scaleEffect(3)
                }
                
            }
        }
        .alert("Error", isPresented: $authViewModel.showAlert, presenting: authViewModel.error) { details in
            Button("OK") {
                authViewModel.showAlert.toggle()
            }
        } message: { details in
            Text(details.error)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
}
extension RegisterView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !fullName.isEmpty
        && fullName.count > 5
        && !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && selectedGender != nil
    }
}
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

