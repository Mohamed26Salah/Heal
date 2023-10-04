//
//  HealthViewModel.swift
//  Heal
//
//  Created by Mohamed Salah on 01/10/2023.
//

import Foundation
import HealthKit
class HealthViewModel: ObservableObject {
    
    @Published var userHealthProfile: UserHealthProfile?
    
    var healthStore: HKHealthStore!
    private let healthKitManager: HealthKitManaging
    init(healthKitManager: HealthKitManaging = HealthKitManager()) {
        guard HKHealthStore.isHealthDataAvailable() else { fatalError("This app requires a device that supports HealthKit") }
        self.healthKitManager = healthKitManager
        healthStore = HKHealthStore()
        requestHealthkitPermissions()
        userHealthProfile = UserHealthProfile()
        initialize()
    }
    private func requestHealthkitPermissions() {
        let healthKitTypesToWrite = Set([
            HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.workoutType()
        ])
        let healthKitTypesToRead = Set([
            HKQuantityType(.heartRate),
            HKQuantityType(.stepCount),
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
            HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
            HKObjectType.characteristicType(forIdentifier: .bloodType)!,
            HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
            HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: .height)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ])
        
        healthStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) in
            print("Request Authorization -- Success: ", success, " Error: ", error ?? "nil")
        }
    }
    func initialize() {
        getUserHeathProfileData()
        getUserHeight()
        getUserWeight()
    }
    private func getUserHeathProfileData() {
        do {
            let userAgeSexAndBloodType = try healthKitManager.getAgeSexAndBloodType()
            self.userHealthProfile?.age = userAgeSexAndBloodType.age
            self.userHealthProfile?.biologicalSex = userAgeSexAndBloodType.biologicalSex
            self.userHealthProfile?.bloodType = userAgeSexAndBloodType.bloodType
        } catch {
            print("getUserHeathProfileData Error \(error)")
        }
    }
    private func getUserHeight() {
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
          print("Height Sample Type is no longer available in HealthKit")
          return
        }
        healthKitManager.getMostRecentSample(for: heightSampleType) { (sample, error) in
          guard let sample = sample else {
            if let error = error {
                print("getUserHeight Error \(error)")
            }
            return
          }
          let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            self.userHealthProfile?.height = heightInMeters
        }
    }
    private func getUserWeight() {
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
          print("Body Mass Sample Type is no longer available in HealthKit")
          return
        }
        healthKitManager.getMostRecentSample(for: weightSampleType) { (sample, error) in
          guard let sample = sample else {
            if let error = error {
                print("getUserWeight Error \(error)")
            }
            return
          }
          let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.userHealthProfile?.weight = weightInKilograms
        }

    }

}
extension HKHealthStore: ObservableObject{}

