//
//  GenderSelectionView.swift
//  Heal
//
//  Created by Mohamed Salah on 20/09/2023.
//

import SwiftUI

struct GenderSelectionView: View {
    @Binding var selectedGender: Gender?
    let gender: Gender
    
    var body: some View {
        Button(action: {
            withAnimation {
                if selectedGender == gender {
                    selectedGender = nil
                } else {
                    selectedGender = gender
                }
            }
        }) {
            Image(gender.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
//                .padding(10)
                .colorMultiply(selectedGender == gender ? .white : .gray)
                .scaleEffect(selectedGender == gender ? 1.2 : 1.0)
        }
    }
}

//#Preview {
//    @State var test = false
//    GenderSelectionView(isMaleSelected: .constant(true), gender: .male)
//}

