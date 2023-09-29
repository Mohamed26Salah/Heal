//
//  DashBoard.swift
//  Heal
//
//  Created by Mohamed Salah on 29/09/2023.
//

import SwiftUI

struct DashBoard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hey Emily,")
                .font(
                    Font.custom("Lato", size: 46)
                        .weight(.bold)
                )
                .foregroundColor(.primary)
                .frame(width: 299, height: 60, alignment: .topLeading)
        }
    }
}

#Preview {
    DashBoard()
}
