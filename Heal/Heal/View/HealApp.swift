//
//  HealApp.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI
import Firebase
@main
struct HealApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
//    init(){
//        FirebaseApp.configure()
//    }
    var body: some Scene {
        WindowGroup {
            if authViewModel.userSession != nil {
                ContentView()
                    .environmentObject(authViewModel)
                    .transition(.opacity)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
                    .transition(.opacity)
            }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
