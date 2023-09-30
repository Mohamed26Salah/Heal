//
//  CircularProgressView.swift
//  Heal
//
//  Created by Mohamed Salah on 30/09/2023.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    var body: some View {
        ZStack { // 1
            Circle()
                .stroke(
                    Color(red: 0.996, green: 0.996, blue: 0.996).opacity(0.5),
                    lineWidth: 13
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(red: 0.45, green: 0.81, blue: 0.83),
                    // 1
                    style: StrokeStyle(
                        lineWidth: 13,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}
#Preview {
    CircularProgressView(progress: 0.25)
}
