//
//  LoadingScreen.swift
//  Heal
//
//  Created by Mohamed Salah on 05/10/2023.
//

import SwiftUI

struct LoadingScreen: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Image("healLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 310, height: 258)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                            self.isAnimating = true
                        }
                    }
                Spacer()
            }
        }
    }
}



#Preview {
    LoadingScreen()
}
