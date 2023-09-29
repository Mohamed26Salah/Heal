//
//  NotificationView.swift
//  Heal
//
//  Created by Mohamed Salah on 29/09/2023.
//

import SwiftUI
struct NotificationMessage: Identifiable, Codable {
    let id: String
    let message: String
}
struct NotificationView: View {
    @Environment(\.colorScheme) var colorScheme
    let notifications: [NotificationMessage] = [
        NotificationMessage(id: "1", message: "Congratulations! You have completed 20 workouts this week."),
        NotificationMessage(id: "2", message: "Your nutrition is very low, Here is a tip to improve it."),
        NotificationMessage(id: "3", message: "You’re just closer to achieve your goals!"),
        NotificationMessage(id: "4", message: "You’re just closer to achieve your goals!"),
        NotificationMessage(id: "5", message: "your watch is connected successfully"),
    ]
    var body: some View {
        VStack{
            GeometryReader { geometry in
                HStack(){
                    Spacer()
                    ScrollView {
                        VStack(spacing: 36){
                            ForEach(notifications) { notification in
                                NotificationBody(message: notification.message)
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    .frame(height: geometry.size.height - 110)
                    Spacer()
                }
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 132, height: 38)
                        .background(
                            (colorScheme == .light) ?
                            AnyView(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.32, green: 0.91, blue: 0.95).opacity(0.32), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.19, green: 0.73, blue: 0.76).opacity(0.24), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.06, y: -0.02),
                                    endPoint: UnitPoint(x: 0.84, y: 0.97)
                                )
                            ) :
                            AnyView(Color(red: 0.03, green: 0.73, blue: 0.78))
                        )

                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: 0.5)
                                .stroke(.white.opacity(0.3), lineWidth: 1)
                        )
                    Text("Clear all")
                        .font(Font.custom("Lato", size: 19))
                        .foregroundColor(.primary)
                        .frame(width: 75, height: 27, alignment: .topLeading)
                }
            })
            .padding(.top, -100)
            Spacer()
        }
    }
}

struct NotificationBody: View {
    var message: String
    @State private var isExpanded: Bool = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: isExpanded ? nil : 89)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color("NotificationFGC").opacity(0.32), location: 0.00),
                            Gradient.Stop(color: Color("NotificationSGC").opacity(0.24), location: 1.00),
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
            
            VStack(alignment: .center, spacing: 5) {
                Text(message)
                    .font(Font.custom("Lato", size: 19))
                    .foregroundColor(.primary)
                    .lineLimit(isExpanded ? nil : 2)
                    .padding(10)
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
                if !isExpanded && message.count > 100 {
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        Text("Read more")
                            .foregroundColor(.primary)
                            .font(.subheadline)
                            .padding(.bottom, 5)
                    }
                }
            }
        }
    }
}
#Preview {
    NotificationView()
}
