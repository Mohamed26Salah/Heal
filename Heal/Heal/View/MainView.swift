//
//  ContentView.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var selectedTap: Tab = .DashBoard
//    @State var showSideMenu = false
    @State private var buttonFrame: CGRect?
    var body: some View {
        GeometryReader { geomtry in
            ZStack(alignment: .topLeading) {
                NavigationStack {
                    VStack{
                        TabView(selection: $selectedTap) {
                            Text("Dashoard")
                                .tag(Tab.DashBoard)
                            ProfileView()
                                .tag(Tab.Profile)
                            Text("Rewards")
                                .tag(Tab.Rewards)
                            VStack{
                                Text("LogOut")
                                Button(action: {
                                    authViewModel.signOut()
                                }, label: {
                                    Text("SignOut")
                                })
                            }
                            .tag(Tab.logout)
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
                    }
                    .navigationTitle("Welcome")
                    .navigationBarHidden(true)
                }
                SideMenu(selectedTab: $selectedTap)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.trailing, geomtry.size.width - 200)
                HStack {
                    Spacer()
                    Button(action: {
                        print("Notification Button Tapped")
                    }, label: {
                        Image(systemName: "bell.fill")
                            .tint(.primary)
                            .bold()
                            .font(.title)
                            .padding(.trailing, 17)
                            .padding(.top, 18)
                            .padding(.bottom, 63)
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
