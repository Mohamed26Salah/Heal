//
//  User.swift
//  Heal
//
//  Created by Mohamed Salah on 20/09/2023.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    let gender: Gender
}
extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Mock Name", email: "Mock@gmail.com", gender: .male)
}

enum Gender: String, Codable {
    case male = "RegisterBoyE"
    case female = "RegisterGirlE"
}
