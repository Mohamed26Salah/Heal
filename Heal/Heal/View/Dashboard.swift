//
//  Dashboard.swift
//  Heal
//
//  Created by Mohamed Salah on 29/09/2023.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var healthViewModel: HealthViewModel
    @State private var selectedChoice: TimeFrame = .weekly
    @Namespace private var test
    var body: some View {
        GeometryReader { geomtry in
            ScrollView {
                VStack(spacing: 40) {
                    HStack{
                        Text("Hey \(authViewModel.currentUser?.fullName ?? "N/A"),")
                            .font(
                                Font.custom("Lato", size: 46)
                                    .weight(.bold)
                            )
                            .foregroundColor(.primary)
                            .padding(.horizontal, 15)
                        Spacer()
                    }
                    ChoicesFilter(oustideGeomtry: geomtry, selectedChoice: $selectedChoice)
                    MainDataView(oustideGeomtry: geomtry, test: _test)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 17), count: 2), spacing: 43) {
                        ForEach(healthViewModel.activityHealthDataArray) { row in
                            GridItemView(image: row.image, data: row.data, message: row.message, unit: row.unit).padding(.horizontal, 10)
                        }
                    }
                    .padding(10)
                    .scaleEffect(self.healthViewModel.activityHealthDataArray.isEmpty ? 0.5 : 1.0)
                    .animation(.easeInOut(duration: 0.5), value: self.healthViewModel.activityHealthDataArray)
                }
            }
        }
        .onChange(of: selectedChoice, perform: { newTimeFrame in
            healthViewModel.updateHealthData(for: newTimeFrame)
        })
    }
//    var testView: some View {
//        Text("Sakah")
//    }
    struct ChoicesFilter:View {
        var oustideGeomtry: GeometryProxy
        let choicesArray: [TimeFrame] = [.today, .weekly, .monthly]
        @State private var ballOffSetLocation: CGFloat = 0
        @State private var orientation = UIDevice.current.orientation
        @Binding var selectedChoice: TimeFrame
        var body: some View {
            ZStack{
                Image("Ellipse 5")
                    .offset(x: ballOffSetLocation, y: 0)
                HStack(spacing: oustideGeomtry.size.width / 3 - 110){
                    ForEach(choicesArray, id: \.self) { choice in
                        Button(action: {
                            withAnimation {
                                self.selectedChoice = choice
                                self.ballOffSetLocation = calculateOffset(for: selectedChoice, totalWidth: oustideGeomtry.size.width)
                            }
                        }) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 108, height: 50)
                                    .background(
                                        LinearGradient(
                                            stops: [
                                                Gradient.Stop(color: Color(red: 0.32, green: 0.91, blue: 0.95).opacity(choice == selectedChoice ? 0.32 : 0.22), location: 0.00),
                                                Gradient.Stop(color: Color(red: 0.19, green: 0.73, blue: 0.76).opacity(choice == selectedChoice ? 0.24 : 0.14), location: 1.00),
                                            ],
                                            startPoint: UnitPoint(x: 0.06, y: -0.02),
                                            endPoint: UnitPoint(x: 0.84, y: 0.97)
                                        )
                                    )
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .inset(by: 0.5)
                                            .stroke(.white.opacity(0.3), lineWidth: 1)
                                    )
                                    .background(.ultraThinMaterial)
                                
                                Text(choice.rawValue)
                                    .font(
                                        Font.custom("Lato", size: 21)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                self.orientation = UIDevice.current.orientation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let screenWidth = oustideGeomtry.size.width
                    withAnimation {
                        self.ballOffSetLocation = calculateOffset(for: selectedChoice, totalWidth: screenWidth)
                    }
                }
            }
        }
        private func calculateOffset(for choice: TimeFrame, totalWidth: CGFloat) -> CGFloat {
            let offsetValue = totalWidth / CGFloat(choicesArray.count) // Calculate offset based on total width and number of choices
            switch choice {
            case .today:
                return -offsetValue
            case .weekly:
                return 0
            case .monthly:
                return offsetValue
            default:
                return 0
            }
        }
    }
    struct MainDataView: View {
        var oustideGeomtry: GeometryProxy
        var test: Namespace
        @State private var progress: CGFloat = 0.0
        @State private var progressNumeric: CGFloat = 0.0
        @State private var number: Int = 0
        @State private var busy: Bool = false
        var body: some View {
            ZStack{
                GeometryReader { geometry in
                    Color.clear
                    ZStack {
                        VStack{
                            Text("Sleep Analysis")
                                .font(
                                    Font.custom("Lato", size: 25)
                                        .weight(.bold)
                                )
                                .foregroundColor(.primary)
                                .padding(.top, 11)
                            HStack{
                                ZStack{
                                    CircularProgressView(progress: progress)
                                        .frame(width: 150,height: 150)
                                    VStack{
                                        Text("Quality")
                                            .font(
                                                Font.custom("Lato", size: 14)
                                                    .weight(.light)
                                            )
                                            .foregroundColor(.primary)
                                        Text("\(number) %")
                                            .font(
                                                Font.custom("Lato", size: 25)
                                                    .weight(.bold)
                                            )
                                            .foregroundColor(.primary)
                                    }
                                }
                                .padding(.leading, 20)
                                Spacer()
                                VStack{
                                    Text("7h 30m")
                                        .font(
                                            Font.custom("Lato", size: 25)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.primary)
                                    Text("Sleep Duration")
                                        .font(
                                            Font.custom("Lato", size: 16)
                                                .weight(.light)
                                        )
                                        .foregroundColor(.primary)
                                }
                                .padding(.trailing, 45)
                            }
                            Image("SleepingGirl")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 312, height: 128)
                                .padding(.leading, 60)
                                .padding(.top, -30)
                                .matchedGeometryEffect(id: "Image", in: test.wrappedValue)
                        }
                    }
                }
                .frame(width: oustideGeomtry.size.width - 30, height: 307)
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
            }
            .onAppear {
                Timer.animateNumber(number: $number, busy: $busy, start: 0, end: 84, duration: 1.5)
                withAnimation(.easeInOut(duration: 1.0)) {
                    progress = 0.84
                }
            }
        }
    }
}

#Preview {
    Dashboard()
}

