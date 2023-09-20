//
//  LoginView.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack {
                        Image("healLogo")
                        HStack(alignment: .top) {
                            VStack {
                                Image("Ellipse 7")
                                    .padding(.top, 406)
                            }
                            VStack {
                                Image("Ellipse 5")
                                    .padding(.top, 508)
                            }
                            VStack {
                                Image("Ellipse 4")
                                    .padding(.top, 40)
                            }
                        }
                        Spacer()
                        
                    }
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: nil, height: 365)
                        .background(.ultraThinMaterial)
                        .blur(radius: 5)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: 0.5)
                                .stroke(.white.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal, 27)
                        .padding(.top, 180)
                    VStack (alignment: .leading, spacing: 38){
                        Text("Sign In")
                            .font(.custom("Lato-Bold", size: 30))
                            .foregroundColor(.primary)
                        CustomTextField(customKeyboardChoice: .email, hint: "Email", text: $email)
                            .padding(.top, -10)
                        SecureTextFieldCustom(hint: "Password", text: $password)
                        HStack(spacing: 0) {
                            Spacer()
                            NavigationLink {
                                ForgotPasswordView()
                            } label: {
                                Text("Forgot Password?")
                                    .font(Font.custom("Lato", size: 12))
                                    .foregroundColor(Color(red: 0.3, green: 0.71, blue: 0.74))
                            }
                            
                        }
                        .padding(.top, -30)
                        
                        HStack {
                            Button(action: {
                                Task{
                                   try await authViewModel.signIn(withEmail:email, password:password)
                                }
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Sign In")
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
                            Text("Didn't Join Yet? ")
                                .font(Font.custom("Lato", size: 12))
                                .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                            NavigationLink {
                                RegisterView()
                                    .navigationBarBackButtonHidden()
                            } label: {
                                Text("Sign Up")
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
    
}
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
