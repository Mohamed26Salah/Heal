//
//  GridItemView.swift
//  Heal
//
//  Created by Mohamed Salah on 24/09/2023.
//

import SwiftUI

struct GridItemView: View {
    var image: String = "burningCalories"
    var data: String = "0.0"
    var message: String = "No Data"
    var unit: String = "N/A"
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                Color.clear
                ZStack(alignment:.leading){
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .padding(.top, 40)
                        .padding(.leading, 65)
                    VStack(alignment: .leading){
                        HStack(spacing: 2) {
                            Text(data)
                                .font(
                                    Font.custom("Lato", size: 25)
                                        .weight(.bold)
                                )
                                .foregroundColor(.primary)
                            Text(unit)
                                .font(
                                    Font.custom("Lato", size: 12)
                                        .weight(.bold)
                                )
                                .foregroundColor(.gray)
                        }
                        Text(message)
                            .font(
                                Font.custom("Lato", size: 10)
                                    .weight(.light)
                            )
                            .foregroundColor(.primary)
                            .opacity(0.6)
                        Spacer()
                    }
                    .padding(.top, 38)
                    .padding(.leading, 14)
                   
                }
            }
            .frame(width: 177, height: 167)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.32, green: 0.91, blue: 0.95).opacity(0.32), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.19, green: 0.73, blue: 0.76).opacity(0.24), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.06, y: -0.02),
                    endPoint: UnitPoint(x: 0.84, y: 0.97)
                )
            )
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

#Preview {
    GridItemView()
}
