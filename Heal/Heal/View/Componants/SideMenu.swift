//
//  SideMenu.swift
//  Heal
//
//  Created by Mohamed Salah on 23/09/2023.
//

import SwiftUI
enum Tab: String, CaseIterable {
    case DashBoard
    case Profile
    case Rewards
    case logout
}
struct SideMenu: View {
    @Binding var selectedTab: Tab
    @State var showSideMenu: Bool = false
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    var body: some View {
        HStack{
            VStack(alignment: .leading,spacing: 21, content: {
                Button(action: {
                    withAnimation {
                        showSideMenu.toggle()
                    }
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .tint(.primary)
                        .bold()
                        .font(.title)
                        .padding(.leading, -9)
                })
                if (showSideMenu) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        HStack{
                            Image("Ellipse 5")
                                .resizable()
                                .frame(width: 6, height: 6)
                                .opacity(selectedTab == tab ? 1 : 0)
                            Text(tab.rawValue)
                                .font(.system(size: 20))
                                .onTapGesture {
                                    feedbackGenerator.impactOccurred()
                                    withAnimation(.easeInOut(duration: 0.1)) {
                                        selectedTab = tab
                                    }
                                }
                        }
                    }
                }
            })
            .padding(.leading, 29)
            .padding(.top, 17)
            .padding(.bottom, 63)
            Spacer()
        }
        .background(
            showSideMenu ?
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.06, green: 0.95, blue: 1).opacity(0.1), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.32, green: 0.91, blue: 0.95).opacity(0.19), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            : nil
        )
    }
}

#Preview {
    SideMenu(selectedTab: .constant(.DashBoard))
}
