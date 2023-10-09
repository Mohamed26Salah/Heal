//
//  UserHealthActivity.swift
//  Heal
//
//  Created by Mohamed Salah on 05/10/2023.
//

import Foundation

class UserHealthActivity: Identifiable, Equatable {

    var id: UUID
    var data: String
    var message: String
    var image: String
    var unit: String
    var name: String
    var type: UserHealthActivityTypeEnum
    
    init(id: UUID = UUID(), data: String, message: String, image: String, unit: String, name: String, userHealthType: UserHealthActivityTypeEnum) {
        self.id = id
        self.data = data
        self.message = message
        self.image = image
        self.unit = unit
        self.name = name
        self.type = userHealthType
    }
    static func == (lhs: UserHealthActivity, rhs: UserHealthActivity) -> Bool {
        return lhs.id == rhs.id &&
               lhs.data == rhs.data &&
               lhs.message == rhs.message &&
               lhs.image == rhs.image &&
               lhs.unit == rhs.unit &&
               lhs.name == rhs.name &&
               lhs.type == rhs.type
    }
}
extension UserHealthActivity {
    static var MOCK_UserHealthActivity = UserHealthActivity(data: "N/A", message: "N/A", image: "walking", unit: "N/A", name: "N/A", userHealthType: .stepCount)
}


enum UserHealthActivityTypeEnum {
    case stepCount
    case heartRate
    case distanceWalkingRunning
    case sleepAnalysis
    case activeEnergyBurned
}
