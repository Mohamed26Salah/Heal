//
//  UserHealthActivity.swift
//  Heal
//
//  Created by Mohamed Salah on 05/10/2023.
//

import Foundation

class UserHealthActivity: Identifiable, Equatable {
    static func == (lhs: UserHealthActivity, rhs: UserHealthActivity) -> Bool {
        return lhs.id == rhs.id &&
               lhs.data == rhs.data &&
               lhs.message == rhs.message &&
               lhs.image == rhs.image &&
               lhs.unit == rhs.unit
    }
    
    var id: UUID
    var data: String
    var message: String
    var image: String
    var unit: String
    
    init(id: UUID = UUID(), data: String, message: String, image: String, unit: String) {
        self.id = id
        self.data = data
        self.message = message
        self.image = image
        self.unit = unit
    }
}

