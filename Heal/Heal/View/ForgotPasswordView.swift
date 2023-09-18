//
//  ForgotPasswordView.swift
//  Heal
//
//  Created by Mohamed Salah on 19/09/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
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
                    .frame(width: nil, height: 250)
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
                VStack (alignment: .leading, spacing: 45){
                    Text("Reset Password")
                        .font(.custom("Lato-Bold", size: 30))
                        .foregroundColor(.primary)
                    CustomTextField(customKeyboardChoice: .email, hint: "put your email", text: $tempLoginState)
                        .padding(.top, -10)
                    
                    HStack {
                        Button(action: {
                            // Add your action here
                        }) {
                            HStack {
                                Spacer()
                                Text("Recover Password ?")
                                    .font(.custom("Lato-Regular", size: 25).weight(.medium))
                                    .foregroundColor(.white)
                                    .frame(width: 280, height: 37)
                                    .background(Color(red: 0.3, green: 0.71, blue: 0.74))
                                    .cornerRadius(6)
                                
                                Spacer()
                            }
                            
                        }
                        
                    }
                    
                }
                .frame(width: nil)
                .padding(.horizontal, 55)
                .padding(.top,170)
                
                
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
}
struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
