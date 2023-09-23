//
//  ProfileView.swift
//  Heal
//
//  Created by Mohamed Salah on 24/09/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView{
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 296, height: 296)
                        .cornerRadius(296)
                        .overlay(
                            RoundedRectangle(cornerRadius: 296)
                                .inset(by: 1.5)
                                .stroke(Color(red: 0.45, green: 0.81, blue: 0.83), lineWidth: 3)
                        )
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 273.91046, height: 273.91046)
                        .background(Color(red: 0.88, green: 0.99, blue: 1))
                        .cornerRadius(273.91046)
                    Image("casual-life-3d-young-woman-")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.leading, 10)
                    Image("Star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 63, height: 60)
                        .rotationEffect(Angle(degrees: 1.23))
                        .padding(.leading, 120)
                        .padding(.top, 240)
                    
                    
                }
                Text("Emily")
                    .font(
                        Font.custom("Lato", size: 32)
                            .weight(.medium)
                    )
                    .foregroundColor(.primary)
                Text("Premium Member")
                    .font(
                        Font.custom("Lato", size: 15)
                            .weight(.light)
                    )
                    .foregroundColor(.primary)
                    .opacity(0.6)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 17), count: 2), spacing: 43) {
                    GridItemView().padding(.horizontal, 10)
                    GridItemView().padding(.horizontal, 10)
                    GridItemView().padding(.horizontal, 10)
                    GridItemView().padding(.horizontal, 10)
                }

                .padding(.horizontal, 10)
            }
        }
    }
}

#Preview {
    ProfileView()
}
