//
//  ContentView.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTap: Tab = .DashBoard
    @State private var showSideMenu = false
    @State private var buttonFrame: CGRect?
    @State private var isNotificationViewVisible = false
    var body: some View {
        GeometryReader { geomtry in
            ZStack(alignment: .topLeading) {
                NavigationStack {
                    VStack{
                        TabView(selection: $selectedTap) {
                            Dashboard()
                                .padding(.top, 70)
                                .tag(Tab.DashBoard)
                            ProfileView()
                                .tag(Tab.Profile)
                            RewardsView()
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
               
                if isNotificationViewVisible {
                    NotificationView()
                        .background(colorScheme == .light ? Color.white : Color.black)
                        .padding(.top, 70)
                }
                SideMenu(selectedTab: $selectedTap, showSideMenu: $showSideMenu, geomtry: geomtry)
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showSideMenu = false
                            isNotificationViewVisible.toggle()

                        }
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
        .onChange(of: selectedTap, perform: { value in
            withAnimation {
                showSideMenu = false
                isNotificationViewVisible = false

            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
