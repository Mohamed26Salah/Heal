//
//  GridItemView.swift
//  Heal
//
//  Created by Mohamed Salah on 24/09/2023.
//

import SwiftUI
struct GridItemView: View {
//    var test: Namespace.ID
    var userHealthActivity = UserHealthActivity.MOCK_UserHealthActivity
//    @State private var yOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Color.clear
                ZStack(alignment:.leading) {
                    Image(userHealthActivity.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .padding(.top, 40)
                        .padding(.leading, 65)
//                        .matchedGeometryEffect(id:"image"+id.uuidString,in:test)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 2) {
                            Text(userHealthActivity.data)
                                .font(
                                    Font.custom("Lato", size: 25)
                                        .weight(.bold)
                                )
                                .foregroundColor(.primary)
//                                .matchedGeometryEffect(id:"data"+id.uuidString,in:test)
//                                .offset(y: -yOffset)
                            
                            Text(userHealthActivity.unit)
                                .font(
                                    Font.custom("Lato", size: 12)
                                        .weight(.bold)
                                )
                                .foregroundColor(.gray)
//                                .matchedGeometryEffect(id:"unit"+id.uuidString,in:test)
//                                .offset(y: -yOffset) // Offset the unit upward
                        }
                        
                        Text(userHealthActivity.message)
                            .font(
                                Font.custom("Lato", size: 10)
                                    .weight(.light)
                            )
                            .foregroundColor(.primary)
                            .opacity(0.6)
//                            .matchedGeometryEffect(id:"message"+id.uuidString,in:test)
//                            .offset(y: -yOffset) // Offset the message upward
                        
                        Spacer()
                    }
                    .padding(.top, 38)
                    .padding(.leading, 14)
                }
//                .offset(y: yOffset) // Offset the entire content upward
//                .onAppear {
//                    // Set an initial yOffset to move content down
//                    yOffset = geometry.size.height
//                }
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
//            .onAppear {
//                // Animate the yOffset to bring content upward
//                withAnimation(.easeInOut(duration: 0.5)) {
//                    yOffset = 0
//                }
//            }
        }
    }
}

//#Preview {
//    GridItemView()
//}
