//ZStack{
//    GeometryReader { geometry in
//        Color.clear
//        ZStack {
//            VStack{
//                Spacer()
//                Text("Sleep Analysis")
//                    .font(
//                        Font.custom("Lato", size: 25)
//                            .weight(.bold)
//                    )
//                    .foregroundColor(.primary)
//                    .padding(.top, 20)
//                HStack{
//                    ZStack{
//                        CircularProgressView(progress: progress)
//                            .frame(width: 150,height: 150)
//                        VStack{
//                            Text("Quality")
//                                .font(
//                                    Font.custom("Lato", size: 14)
//                                        .weight(.light)
//                                )
//                                .foregroundColor(.primary)
//                            Text("\(number) %")
//                                .font(
//                                    Font.custom("Lato", size: 25)
//                                        .weight(.bold)
//                                )
//                                .foregroundColor(.primary)
//                        }
//                    }
//                    .padding(.leading, 20)
//                    Spacer()
//                    VStack{
//                        Text("7h 30m")
//                            .font(
//                                Font.custom("Lato", size: 25)
//                                    .weight(.bold)
//                            )
//                            .foregroundColor(.primary)
//                        Text("Sleep Duration")
//                            .font(
//                                Font.custom("Lato", size: 16)
//                                    .weight(.light)
//                            )
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.trailing, 45)
//                }
//                Image("SleepingGirl")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 312, height: 128)
//                    .padding(.leading, 60)
//                    .padding(.top, -30)
//            }
//        }
//    }
//    .frame(width: geomtry.size.width - 30, height: 307)
//    .background(
//        LinearGradient(
//            stops: [
//                Gradient.Stop(color: Color(red: 0.32, green: 0.91, blue: 0.95).opacity(0.32), location: 0.00),
//                Gradient.Stop(color: Color(red: 0.19, green: 0.73, blue: 0.76).opacity(0.24), location: 1.00),
//            ],
//            startPoint: UnitPoint(x: 0.06, y: -0.02),
//            endPoint: UnitPoint(x: 0.84, y: 0.97)
//        )
//    )
//    .cornerRadius(20)
//    .overlay(
//        RoundedRectangle(cornerRadius: 20)
//            .inset(by: 0.5)
//            .stroke(.white.opacity(0.3), lineWidth: 1)
//    )
//}
//ZStack {
//    GeometryReader { geomtry2 in
//        Color.clear
//        ZStack {
//            VStack{
//                Spacer()
//                Text("Sleep Analysis")
//                    .font(
//                        Font.custom("Lato", size: 25)
//                            .weight(.bold)
//                    )
//                    .foregroundColor(.primary)
//                    .padding(.top, 20)
//                HStack{
//                    ZStack{
//                        CircularProgressView(progress: progress)
//                            .frame(width: 150,height: 150)
//                        VStack{
//                            Text("Quality")
//                                .font(
//                                    Font.custom("Lato", size: 14)
//                                        .weight(.light)
//                                )
//                                .foregroundColor(.primary)
//                            Text("\(number) %")
//                                .font(
//                                    Font.custom("Lato", size: 25)
//                                        .weight(.bold)
//                                )
//                                .foregroundColor(.primary)
//                        }
//                    }
//                    .padding(.leading, 20)
//                    Spacer()
//                    VStack{
//                        Text("7h 30m")
//                            .font(
//                                Font.custom("Lato", size: 25)
//                                    .weight(.bold)
//                            )
//                            .foregroundColor(.primary)
//                        Text("Sleep Duration")
//                            .font(
//                                Font.custom("Lato", size: 16)
//                                    .weight(.light)
//                            )
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.trailing, 45)
//                }
//                Image("SleepingGirl")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 312, height: 128)
//                    .padding(.leading, 60)
//                    .padding(.top, -30)
//            }
//        }
//    }
//    .frame(maxHeight: 307)
//}
//.frame(width: geomtry.size.width - 30, height: 307)
//.background {
//    LinearGradient(
//        stops: [
//            Gradient.Stop(color: Color(red: 0.32, green: 0.91, blue: 0.95).opacity(0.32), location: 0.00),
//            Gradient.Stop(color: Color(red: 0.19, green: 0.73, blue: 0.76).opacity(0.24), location: 1.00),
//        ],
//        startPoint: UnitPoint(x: 0.06, y: -0.02),
//        endPoint: UnitPoint(x: 0.84, y: 0.97)
//    )
//    .cornerRadius(20)
//    .overlay(
//        RoundedRectangle(cornerRadius: 20)
//            .inset(by: 0.5)
//            .stroke(.white.opacity(0.3), lineWidth: 1)
//    )
//}



//n both of the provided code blocks, you have two ZStack containers, each containing the same content for "Sleep Analysis." The difference between them lies in how they are structured and nested, which affects the layout and rendering of the content.
//
//In the first code block:
//
//swift
//Copy code
//ZStack {
//    GeometryReader { geometry in
//        // ...
//    }
//    .frame(width: geomtry.size.width - 30, height: 307)
//    .background {
//        LinearGradient {
//            // ...
//        }
//    }
//}
//The GeometryReader wraps the entire ZStack, and the background is applied as a modifier to the ZStack. This structure places the background behind the content, giving the impression that the image is trapped inside the view.
//
//In the second code block:
//
//swift
//Copy code
//ZStack {
//    GeometryReader { geomtry2 in
//        // ...
//    }
//    .frame(maxHeight: 307)
//}
//.frame(width: geomtry.size.width - 30, height: 307)
//.background {
//    LinearGradient {
//        // ...
//    }
//}
//In this structure, the GeometryReader wraps only the content within the inner ZStack, and the background is applied as a modifier to the outer ZStack. This layout can lead to the image appearing outside the view because the background is applied to the outer ZStack, and the content is rendered within it.
//
//If you want to achieve the effect where the image is trapped inside the view, you should use the structure from the first code block, where the GeometryReader wraps the entire ZStack, and the background is applied as a modifier to the same ZStack. This arrangement ensures that the content, including the image, is contained within the background frame.
