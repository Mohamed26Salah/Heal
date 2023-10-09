//
//  RewardsView.swift
//  Heal
//
//  Created by Mohamed Salah on 29/09/2023.
//

import SwiftUI

struct RewardsView: View {
    let testArray = [
        UserHealthActivity.MOCK_UserHealthActivity,
        UserHealthActivity.MOCK_UserHealthActivity,
        UserHealthActivity.MOCK_UserHealthActivity,
        UserHealthActivity.MOCK_UserHealthActivity
    ]
    @EnvironmentObject var healthViewModel: HealthViewModel
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                HStack {
                    Spacer()
                    VStack(spacing: 30) {
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
//                                .frame(width: 405, height: 374)
//                                .padding(.leading, 10)
                                .rotationEffect(Angle(degrees: -18.73))
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 273.91046, height: 273.91046)
                                .background(Color(red: 0.88, green: 0.99, blue: 1))
                                .cornerRadius(273.91046)
                            Image("profileG")
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
//                        Divider()
                        ForEach(healthViewModel.activityHealthDataArray) { row in
                            VStack {
                                Text(row.name)
                                    .font(
                                        Font.custom("Lato", size: 25)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.primary)
                                ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                                    challengiesView(name: timeFrame.rawValue.capitalized, progress: healthViewModel.mapValue(value: healthViewModel.checkTheProgress(time: timeFrame, userHealthActivity: row), fromRange: 0.0...100.0, toRange: 0.0...1.0))
                                }
                                .frame(width: geometry.size.width - 20, height: 120)
                                Divider()
                                    .padding(.top, 10)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }

    }
}
struct challengiesView: View {
    var name: String
    var progress: CGFloat
//    var geometry: GeometryProxy
//    var showRewardsButton: Bool = false
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(alignment: .leading) {
                Text(name)
                    .font(
                        Font.custom("Lato", size: 20)
                            .weight(.bold)
                    )
                    .foregroundColor(.primary)
                    .padding(.bottom, 10)
                LinearProgressView(progress: progress)
                    .padding(.bottom, 10)
//                if progress == 1.0 {
//                    Button(action: {
//                    }) {
//                        HStack {
//                            Spacer()
//                            Text("Rewards")
//                                .font(.custom("Lato-Regular", size: 25).weight(.medium))
//                                .foregroundColor(.white)
//                                .frame(width: geometry.size.width - 250, height: 37)
//                                .background(Color(red: 0.3, green: 0.71, blue: 0.74))
//                                .cornerRadius(6)
//                            Spacer()
//                        }
//                        
//                    }
//                }
            }
            .padding()
        })
        //        .frame(height: 50)
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

#Preview {
        RewardsView()
//    challengiesView(name: "Daily", progress: 1.0)
}

















//                Text("Congratulations!")
//                    .font(
//                        Font.custom("Lato", size: 32)
//                            .weight(.medium)
//                    )
//                    .foregroundColor(.primary)
//                ZStack(alignment: .top) {
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 355, height: 342)
//                        .background(
//                            LinearGradient(
//                                stops: [
//                                    Gradient.Stop(color: Color(red: 0.32, green: 0.91, blue: 0.95).opacity(0.32), location: 0.00),
//                                    Gradient.Stop(color: Color(red: 0.19, green: 0.73, blue: 0.76).opacity(0.24), location: 1.00),
//                                ],
//                                startPoint: UnitPoint(x: 0.06, y: -0.02),
//                                endPoint: UnitPoint(x: 0.84, y: 0.97)
//                            )
//                        )
//                        .cornerRadius(20)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .inset(by: 0.5)
//                                .stroke(.white.opacity(0.3), lineWidth: 1)
//                        )
//                    VStack{
//                        Text("Emily has attempted 20 workouts this week.")
//                            .font(Font.custom("Lato", size: 23))
//                            .foregroundColor(.black)
//                            .frame(width: 254, height: 78, alignment: .topLeading)
//                            .padding(.top, 39)
//                        HStack(alignment: .center){
//                            Image("cup")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 156, height: 197)
//                                .padding(.leading, 10)
//                                .rotationEffect(Angle(degrees: -25.04))
//                                .padding(.leading, 25)
//                            Image("congratulation")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 156, height: 197)
//                                .padding(.leading, 10)
//                                .rotationEffect(Angle(degrees: -95))
//                        }
//                    }
//                }
