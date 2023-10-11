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
    @State private var isLogoutAlertPresented = false
    @State private var previousTab: Tab = .DashBoard
    var body: some View {
        GeometryReader { geomtry in
            ZStack(alignment: .topLeading) {
                if showSideMenu {
                    Color.black.opacity(0.001) // Transparent background
                        .onTapGesture {
                            withAnimation {
                                showSideMenu = false
                            }
                        }
                }
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
            .onTapGesture {
                if showSideMenu {
                    previousTab = selectedTap
                    withAnimation {
                        showSideMenu = false
                    }
                }
            }
        }
        .onChange(of: selectedTap, perform: { value in
            if value == .logout {
                isLogoutAlertPresented.toggle()
            }
            withAnimation {
                showSideMenu = false
                isNotificationViewVisible = false
                
            }
            
        })
        .alert(isPresented: $isLogoutAlertPresented) {
            Alert(
                title: Text("Are you sure you want to log out?"),
                message: Text("You can always log in again later."),
                primaryButton: .destructive(Text("Yes")) {
                    authViewModel.signOut()
                },
                secondaryButton: .cancel(Text("No")) {
                    selectedTap = previousTab
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
