//
//  ProfileView.swift
//  Heal
//
//  Created by Mohamed Salah on 24/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var healthViewModel: HealthViewModel
    var body: some View {
        VStack (alignment:.center) {
            GeometryReader { geometry in
                HStack{
                    Spacer()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: geometry.size.width * scaleFactorForWidth,
                                   height: geometry.size.width * scaleFactorForHeight)
                            .cornerRadius(geometry.size.width * scaleFactorForWidth / 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: geometry.size.width * scaleFactorForWidth / 2)
                                    .inset(by: 1.5)
                                    .stroke(Color(red: 0.45, green: 0.81, blue: 0.83), lineWidth: 3)
                            )
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: geometry.size.width * scaleFactorForWidthBackground,
                                   height: geometry.size.width * scaleFactorForHeightBackground)
                            .background(Color(red: 0.88, green: 0.99, blue: 1))
                            .cornerRadius(geometry.size.width * scaleFactorForWidthBackground / 2)
                        
                        Image("casual-life-3d-young-woman-")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * scaleFactorForImage,
                                   height: geometry.size.width * scaleFactorForImage)
                            .padding(.leading, 10)
                    }
                    Spacer()
                }
            }
            Text(authViewModel.currentUser?.fullName ?? "N/A")
                .font(
                    Font.custom("Lato", size: 32)
                        .weight(.medium)
                )
                .foregroundColor(.primary)
                .padding(.top, 12)
            Text("Premium Member")
                .font(
                    Font.custom("Lato", size: 15)
                        .weight(.light)
                )
                .foregroundColor(.primary)
                .opacity(0.6)
            List {
                Section(header: Text("Personal Information")) {
                    // Age, biological sex, and blood type
                    HStack {
                        Text("Age")
                        Spacer()
                        Text("\(healthViewModel.userHealthProfile?.age ?? 0)")
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("Sex")
                        Spacer()
                        Text(healthViewModel.userHealthProfile?.biologicalSex?.stringValue ?? "N/A")
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("Blood Type")
                        Spacer()
                        Text(healthViewModel.userHealthProfile?.bloodType?.stringValue ?? "N/A")
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                    
                }
                Section(header: Text("Physical Metrics")) {
                    HStack {
                        Text("Weight (Kg)")
                        Spacer()
                        
                        Text(String(format: "%.2f", healthViewModel.userHealthProfile?.weight ?? "N/A"))
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("Height (m)")
                        Spacer()
                        Text(String(format: "%.2f", healthViewModel.userHealthProfile?.height ?? "N/A"))
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("Body Mass Index (BMI)")
                        Spacer()
                        Text(String(format: "%.2f", healthViewModel.userHealthProfile?.bodyMassIndex ?? "N/A"))
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                }
            }
            
        }
        .padding(.top, 60)
    }
    private var isLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
    private var scaleFactorForWidth: CGFloat {
        return isLandscape ? 0.2 : 0.6
    }
    
    private var scaleFactorForHeight: CGFloat {
        return isLandscape ? 0.2 : 0.6
    }
    
    private var scaleFactorForWidthBackground: CGFloat {
        return isLandscape ? 0.175 : 0.55
    }
    
    private var scaleFactorForHeightBackground: CGFloat {
        return isLandscape ? 0.175 : 0.55
    }
    
    private var scaleFactorForImage: CGFloat {
        return isLandscape ? 0.15 : 0.5
    }
}

#Preview {
    ProfileView()
}
