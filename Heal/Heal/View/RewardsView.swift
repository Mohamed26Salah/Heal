//
//  RewardsView.swift
//  Heal
//
//  Created by Mohamed Salah on 29/09/2023.
//

import SwiftUI

struct RewardsView: View {
    var body: some View {
        ScrollView {
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
                    Image("sprinklesImages")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 405, height: 374)
                        .padding(.leading, 10)
                        .rotationEffect(Angle(degrees: -18.73))
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
                }
                Text("Congratulations!")
                    .font(
                        Font.custom("Lato", size: 32)
                            .weight(.medium)
                    )
                    .foregroundColor(.primary)
                ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 355, height: 342)
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
                    VStack{
                        Text("Emily has attempted 20 workouts this week.")
                            .font(Font.custom("Lato", size: 23))
                            .foregroundColor(.black)
                            .frame(width: 254, height: 78, alignment: .topLeading)
                            .padding(.top, 39)
                        HStack(alignment: .center){
                            Image("cup")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 156, height: 197)
                                .padding(.leading, 10)
                                .rotationEffect(Angle(degrees: -25.04))
                                .padding(.leading, 25)
                            Image("congratulation")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 156, height: 197)
                                .padding(.leading, 10)
                                .rotationEffect(Angle(degrees: -95))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RewardsView()
}
