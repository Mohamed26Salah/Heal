//
//  CustomFostkBackground.swift
//  Heal
//
//  Created by Mohamed Salah on 29/09/2023.
//

import SwiftUI

struct CustomFostkBackground: View {
    var width: CGFloat
    var height: CGFloat
    var CornerRadius: CGFloat
    var gradientOneColor: Color
    var gradientTwoColor: Color
    var gradientOneLocation: CGFloat
    var gradientTwoLocation: CGFloat
    var startPoint: UnitPoint
    var endPoint: UnitPoint
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: width, height: height)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: gradientOneColor, location: gradientOneLocation),
                        Gradient.Stop(color: gradientTwoColor, location: gradientTwoLocation),
                    ],
                    startPoint: startPoint,
                    endPoint: endPoint
                )
            )
            .cornerRadius(CornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius)
                    .inset(by: 0.5)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            )
    }
}

//#Preview {
//    CustomFostkBackground(width: 10, height: 10, CornerRadius: 10)
//}
