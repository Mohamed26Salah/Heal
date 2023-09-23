//
//  ContentView.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var selectedTap: Tab = .DashBoard
//    @State var showSideMenu = false
    @State private var buttonFrame: CGRect?
    var body: some View {
        GeometryReader { geomtry in
            ZStack(alignment: .topLeading) {
                NavigationStack {
                    VStack{
                        Text("3ash you are signed In")
                        Button(action: {
                            authViewModel.signOut()
                        }, label: {
                            Text("SignOut")
                        })
                    }
                    .navigationTitle("Welcome")
//                    .toolbar {
//                        ToolbarItemGroup(placement: .topBarLeading) {
//                            Button(action: {
//                                withAnimation {
//                                    showSideMenu.toggle()
//                                }
//                            }, label: {
//                                Image(systemName: "slider.horizontal.3")
//                                    .tint(.primary)
//                            })
//                            
//                        }
//                    }
                    .navigationBarHidden(true)
                }
                SideMenu(selectedTab: $selectedTap)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.trailing, geomtry.size.width - 200)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
