//
//  HealthViewModel.swift
//  Heal
//
//  Created by Mohamed Salah on 01/10/2023.
//

import Foundation
import HealthKit
@MainActor
class HealthViewModel: ObservableObject {
    
    @Published var userHealthProfile: UserHealthProfile?
    @Published var stepCount: Double = 0.0
    @Published var heartRate: Double = 0.0
    @Published var activeEnergyBurned: Double = 0.0
    @Published var sleepAnalysis: Double = 0.0
    @Published var distanceWalkingRunning: Double = 0.0
    @Published var timeFrame: TimeFrame = .weekly
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
        getUserStepCount()
        getUserHeartRate()
        getUserActiveEnergyBurned()
        getUserSleepAnalysis()
        getDistanceWalkingRunning()
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
            DispatchQueue.main.async {
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
    }
    private func getUserWeight() {
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
          print("Body Mass Sample Type is no longer available in HealthKit")
          return
        }
        healthKitManager.getMostRecentSample(for: weightSampleType) { (sample, error) in
            DispatchQueue.main.async {
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
    private func getUserStepCount() {
        healthKitManager.getStepCount(forTimeFrame: timeFrame) { stepCount, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print(error)
                    return
                }
                if let stepCount = stepCount {
                    self.stepCount = stepCount
                }
            }
        }
    }
    private func getUserHeartRate() {
        healthKitManager.getAverageHeartRate(forTimeFrame: timeFrame) { avgHeartRate, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print(error)
                    return
                }
                if let avgHeartRate = avgHeartRate {
                    self.heartRate = avgHeartRate
                }
            }
        }
    }
    private func getUserActiveEnergyBurned() {
        healthKitManager.getActiveEnergyBurned(forTimeFrame: timeFrame) { activeEnergyBurned, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print(error)
                    return
                }
                if let activeEnergyBurned = activeEnergyBurned {
                    self.activeEnergyBurned = activeEnergyBurned
                }
            }
        }
    }
    private func getUserSleepAnalysis() {
        healthKitManager.getSleepAnalysis(forTimeFrame: timeFrame) { sleepAnalysis, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print(error)
                    return
                }
                if let sleepAnalysis = sleepAnalysis {
                    self.sleepAnalysis = sleepAnalysis
                }
            }
        }
    }
    private func getDistanceWalkingRunning() {
        healthKitManager.getDistanceWalkingRunning(forTimeFrame: timeFrame) { distanceWalkingRunning, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print(error)
                    return
                }
                if let distanceWalkingRunning = distanceWalkingRunning {
                    self.distanceWalkingRunning = distanceWalkingRunning
                }
            }
        }
    }

}
extension HKHealthStore: ObservableObject{}

