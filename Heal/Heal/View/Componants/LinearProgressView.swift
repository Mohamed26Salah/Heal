//
//  LinearProgressView.swift
//  Heal
//
//  Created by Mohamed Salah on 09/10/2023.
//

import SwiftUI

struct LinearProgressView: View {
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.addLines([
                        CGPoint(x: 0, y: height / 2),
                        CGPoint(x: width * self.progress, y: height / 2)
                    ])
                }
                .stroke(style: StrokeStyle(lineWidth: 13, lineCap: .round))
                .foregroundColor(Color(red: 0.45, green: 0.81, blue: 0.83))
                .animation(.easeOut, value: progress)
                Text(String(format: "%.1f", progress * 100) + "%")
                    .font(
                        Font.custom("Lato", size: 15)
                            .weight(.bold)
                    )
                    .foregroundColor(.primary)
                    .position(x: ((geometry.size.width) - 12) * self.progress, y: geometry.size.height / 2)
            }
        }
        .frame(height: 13)
        .background(Color(red: 0.996, green: 0.996, blue: 0.996).opacity(0.5))
    }
}
#Preview {
    LinearProgressView(progress: 0.84)
}
