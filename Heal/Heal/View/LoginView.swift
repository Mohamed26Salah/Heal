//
//  LoginView.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI

struct LoginView: View {
    @State var tempLoginState: String = ""
    var body: some View {
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
                    CustomTextField(customKeyboardChoice: .email, hint: "Email", text: $tempLoginState)
                        .padding(.top, -10)
                    SecureTextFieldCustom(hint: "Password", text: $tempLoginState)
                    HStack(spacing: 0) {
                        Spacer()
                        Button(action: {
                            // Add your action here
                        }) {
                            Text("Forgot Password?")
                                .font(Font.custom("Lato", size: 12))
                                .foregroundColor(Color(red: 0.3, green: 0.71, blue: 0.74))
                        }

                    }
                    .padding(.top, -30)
                    
                    HStack {
                        Button(action: {
                            // Add your action here
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
                        
                    }
                    .padding(.top, -16)
                    HStack(spacing: 0) {
                        Spacer()
                        Text("Didn't Join Yet? ")
                            .font(Font.custom("Lato", size: 12))
                            .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                        Button(action: {
                            // Add your action here
                        }) {
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
                
                
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
