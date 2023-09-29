//
//  Dashboard.swift
//  Heal
//
//  Created by Mohamed Salah on 29/09/2023.
//

import SwiftUI

struct Dashboard: View {
    let choicesArray = ["Daily", "Weekly", "Monthly"]
    @State private var selectedChoice: String = "Weekly"
    @State private var ballOffSetLocation: CGFloat = 0
    
    var body: some View {
        GeometryReader { geomtry in
            VStack {
                HStack{
                    Text("Hey Emily,")
                        .font(
                            Font.custom("Lato", size: 46)
                                .weight(.bold)
                        )
                        .foregroundColor(.primary)
                        .padding(.horizontal, 15)
                    Spacer()
                }
                ZStack{
                    Image("Ellipse 5")
                        .offset(x: ballOffSetLocation, y: 0)
                    HStack(spacing: geomtry.size.width / 3 - 110){
                        ForEach(choicesArray, id: \.self) { choice in
                            Button(action: {
                                withAnimation {
                                    self.selectedChoice = choice
                                    self.ballOffSetLocation = calculateOffset(for: selectedChoice, totalWidth: geomtry.size.width)
                                }
                            }) {
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 108, height: 50)
                                        .background(
                                            LinearGradient(
                                                stops: [
                                                    Gradient.Stop(color: Color(red: 0.32, green: 0.91, blue: 0.95).opacity(choice == selectedChoice ? 0.32 : 0.22), location: 0.00),
                                                    Gradient.Stop(color: Color(red: 0.19, green: 0.73, blue: 0.76).opacity(choice == selectedChoice ? 0.24 : 0.14), location: 1.00),
                                                ],
                                                startPoint: UnitPoint(x: 0.06, y: -0.02),
                                                endPoint: UnitPoint(x: 0.84, y: 0.97)
                                            )
                                        )
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .inset(by: 0.5)
                                                .stroke(.white.opacity(0.3), lineWidth: 1)
                                        )
                                        .background(.ultraThinMaterial)
                                    
                                    Text(choice)
                                        .font(
                                            Font.custom("Lato", size: 21)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    private func calculateOffset(for choice: String, totalWidth: CGFloat) -> CGFloat {
        let offsetValue = totalWidth / CGFloat(choicesArray.count) // Calculate offset based on total width and number of choices
        switch choice {
        case "Daily":
            return -offsetValue
        case "Weekly":
            return 0
        case "Monthly":
            return offsetValue
        default:
            return 0
        }
    }
}

#Preview {
    Dashboard()
}
