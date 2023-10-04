//
//  UserHealthProfile.swift
//  Heal
//
//  Created by Mohamed Salah on 04/10/2023.
//

import Foundation
import HealthKit

struct UserHealthProfile {
    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?
    var height: Double?
    var weight: Double?
    var bodyMassIndex: Double? {
      guard let weightInKilograms = weight,
        let heightInMeters = height,
        heightInMeters > 0 else {
        return nil
      }
      return (weightInKilograms/(heightInMeters*heightInMeters))
    }
}
extension HKBiologicalSex {
    var stringValue: String {
        switch self {
        case .notSet: return "Not Set"
        case .female: return "Female"
        case .male: return "Male"
        case .other: return "Other"
        @unknown default: return "Unknown"
        }
    }
}

extension HKBloodType {
    var stringValue: String {
        switch self {
        case .notSet: return "Not Set"
        case .aPositive: return "A+"
        case .aNegative: return "A-"
        case .bPositive: return "B+"
        case .bNegative: return "B-"
        case .abPositive: return "AB+"
        case .abNegative: return "AB-"
        case .oPositive: return "O+"
        case .oNegative: return "O-"
        @unknown default: return "Unknown"
        }
    }
}
