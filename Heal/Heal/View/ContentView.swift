//
//  ContentView.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        Button(action: {
                authViewModel.signOut()
        }, label: {
            Text("SignOut")
        })
//        NavigationStack {
//            TabView(selection: $selectedTab) {
//                LoginView()
//                    .badge(2)
//                    .tabItem {
//                        Label("Received", systemImage: "tray.and.arrow.down.fill")
//                    }
//                LoginView()
//                    .tabItem {
//                        Label("Sent", systemImage: "tray.and.arrow.up.fill")
//                    }
//                LoginView()
//                    .badge("!")
//                    .tabItem {
//                        Label("Account", systemImage: "person.crop.circle.fill")
//                    }
//            }
//        }
                
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
