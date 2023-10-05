//
//  AuthViewModel.swift
//  Heal
//
//  Created by Mohamed Salah on 20/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get}
}

@MainActor
struct ErrorDetails: Identifiable {
    let name: String
    let error: String
    let id = UUID()
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var showAlert: Bool = false
    @Published var error: ErrorDetails?
    @Published var showLoading: Bool = false
    @Published var isLoading: Bool = true
    init() {
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    func signIn(withEmail email: String, password: String) async throws {
        self.showLoading = true
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            self.showLoading = false
        } catch {
            self.showLoading = false
            self.showAlert.toggle()
            self.error = ErrorDetails(name: "Error", error: error.localizedDescription)
//            print("DEBUG: Failed to sign In the user with error \(error.localizedDescription)")
        }
    }
    func createUser(withEmail email: String, password: String, fullName: String, gender: Gender) async throws {
        self.showLoading = true
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email, gender: gender)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
            self.showLoading = false
        } catch {
            self.showLoading = false
            self.showAlert.toggle()
            self.error = ErrorDetails(name: "Error", error: error.localizedDescription)
//            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            self.showAlert.toggle()
            self.error = ErrorDetails(name: "Error", error: error.localizedDescription)
//            print("DEBUG: Failed to sign out the user with error \(error.localizedDescription)")
        }
    }
    func deleteAccount() {
        
    }
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapShot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapShot.data(as: User.self)
        self.isLoading = false
    }
}
