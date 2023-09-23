//
//  ContentView.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        Text("3ash you are signed In")
        Button(action: {
                authViewModel.signOut()
        }, label: {
            Text("SignOut")
        })
//        Group {
//            if authViewModel.userSession != nil {
//                Text("3ash you are signed In")
//            } else {
//                LoginView()
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
