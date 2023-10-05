//
//  HealApp.swift
//  Heal
//
//  Created by Mohamed Salah on 18/09/2023.
//

import SwiftUI
import Firebase
import HealthKit
@main
struct HealApp: App {
    //    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //    @StateObject var authViewModel = AuthViewModel()
    //    @StateObject var healthViewModel = HealthViewModel()
    //    init(){
    //        FirebaseApp.configure()
    //    }
    @StateObject var authViewModel: AuthViewModel
    @StateObject var healthViewModel: HealthViewModel // Remove the initialization here
    init() {
        FirebaseApp.configure()
        let authVM = AuthViewModel()
        self._authViewModel = StateObject(wrappedValue: authVM)
        self._healthViewModel = StateObject(wrappedValue: HealthViewModel(authVm: authVM))
    }
    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoading {
                LoadingScreen()
            } else {
                if authViewModel.userSession != nil {
                    MainView()
                        .environmentObject(authViewModel)
                        .environmentObject(healthViewModel)
                        .transition(.opacity)
                } else {
                    LoginRegisterView()
                        .environmentObject(authViewModel)
                        .transition(.opacity)
                }
            }
        }
    }
}
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

//@StateObject var authViewModel: AuthViewModel
//@StateObject var healthViewModel: HealthViewModel // Remove the initialization here
//init() {
//    FirebaseApp.configure()
//    let authVM = AuthViewModel()
//    print(authVM.currentUser?.fullName)
//    self._authViewModel = StateObject(wrappedValue: authVM)
//    self._healthViewModel = StateObject(wrappedValue: HealthViewModel(authViewModel: authVM))
//}
