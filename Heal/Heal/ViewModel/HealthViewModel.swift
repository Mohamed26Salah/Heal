//
//  HealthViewModel.swift
//  Heal
//
//  Created by Mohamed Salah on 01/10/2023.
//

import Foundation
import HealthKit
import Firebase
import Combine
import SwiftUI

enum ImagesController: String {
    case sleep = "sleeping"
    case stepCount = "walking"
    case activeEnergyBurned = "burningCalories"
    case heartRate = "heart"
    case distanceWalkingRunning = "walkingDistance"
    case profile = "profile"
    
    func imageName(isGirl: Bool = false) -> String {
        if isGirl {
            return self.rawValue + "G"
        } else {
            return self.rawValue
        }
    }
}


@MainActor
class HealthViewModel: ObservableObject {
    
    @Published var userHealthProfile: UserHealthProfile?
    @Published var activityHealthDataArray: [UserHealthActivity] = [UserHealthActivity]()
    @Published var mainItemView: UserHealthActivity = UserHealthActivity.MOCK_UserHealthActivity
    @Published var mainItemProgress: CGFloat = 0.0
    @Published var error: ErrorDetails?
    @Published var showAlert: Bool = false
    var cancellables = Set<AnyCancellable>()
    var authViewModel: AuthViewModel
    var healthStore: HKHealthStore!
    var isUserGirl: Bool = false
    private let healthKitManager: HealthKitManaging
    
    init(healthKitManager: HealthKitManaging = HealthKitManager(), authVm: AuthViewModel) {
        guard HKHealthStore.isHealthDataAvailable() else { fatalError("This app requires a device that supports HealthKit") }
        self.healthKitManager = healthKitManager
        self.authViewModel = authVm
        authViewModel.$currentUser
            .sink { [weak self] user in
                self?.activityHealthDataArray.removeAll()
                if user != nil {
                    self?.isUserGirl = (user?.gender == .female)
                    self?.initialize(timeFrame: .weekly)
                }
            }
            .store(in: &cancellables)
        healthStore = HKHealthStore()
        requestHealthkitPermissions()
        userHealthProfile = UserHealthProfile()
        
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
    func initialize(timeFrame: TimeFrame) {
        getUserHeathProfileData()
        getUserHeight()
        getUserWeight()
        getUserStepCount(for: timeFrame)
//        getUserHeartRate(for: timeFrame)
        getUserActiveEnergyBurned(for: timeFrame)
        getUserSleepAnalysis(for: timeFrame)
        getDistanceWalkingRunning(for: timeFrame)
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
    private func getUserStepCount(for timeFrame: TimeFrame) {
        healthKitManager.getStepCount(forTimeFrame: timeFrame) { stepCount, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.showAlert.toggle()
                    self.error = ErrorDetails(name: "Error", error: error?.localizedDescription ?? "Something Went Wrong")
                    return
                }
                if let stepCount = stepCount {
                    self.activityHealthDataArray.append(UserHealthActivity(data: String(format: "%.0f",stepCount), message: "steps", image: ImagesController.stepCount.imageName(isGirl: self.isUserGirl), unit: "steps", name: "Steps Count", userHealthType: .stepCount))
                }
            }
        }
    }
    private func getUserHeartRate(for timeFrame: TimeFrame) {
        healthKitManager.getAverageHeartRate(forTimeFrame: timeFrame) { avgHeartRate, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.showAlert.toggle()
                    self.error = ErrorDetails(name: "Error", error: error?.localizedDescription ?? "Something Went Wrong")
                    return
                }
                if let avgHeartRate = avgHeartRate {
                    self.activityHealthDataArray.append(UserHealthActivity(data: String(format: "%.0f", avgHeartRate), message: "Take Car of you Heart", image: ImagesController.heartRate.imageName(isGirl: self.isUserGirl), unit: "rpm", name: "Heart Rate", userHealthType: .heartRate))
                }
            }
        }
    }
    private func getUserActiveEnergyBurned(for timeFrame: TimeFrame) {
        healthKitManager.getActiveEnergyBurned(forTimeFrame: timeFrame) { activeEnergyBurned, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.showAlert.toggle()
                    self.error = ErrorDetails(name: "Error", error: error?.localizedDescription ?? "Something Went Wrong")
                    return
                }
                if let activeEnergyBurned = activeEnergyBurned {
                    self.activityHealthDataArray.append(UserHealthActivity(data: String(format: "%.1f",activeEnergyBurned), message: "Yeaaaah Lets Go", image: ImagesController.activeEnergyBurned.imageName(isGirl: self.isUserGirl), unit: "kcal", name: "Active Energy", userHealthType: .activeEnergyBurned))
                }
            }
        }
    }
    private func getUserSleepAnalysis(for timeFrame: TimeFrame) {
        healthKitManager.getSleepAnalysis(forTimeFrame: timeFrame) { sleepAnalysis, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.showAlert.toggle()
                    self.error = ErrorDetails(name: "Error", error: error?.localizedDescription ?? "Something Went Wrong")
                    return
                }
                if let sleepAnalysis = sleepAnalysis {
                    self.activityHealthDataArray.append(UserHealthActivity(data: String(format: "%.0f",sleepAnalysis), message: "Go To Sleep", image: ImagesController.sleep.imageName(isGirl: self.isUserGirl), unit: "hours", name: "Sleep Analysis", userHealthType: .sleepAnalysis))
                }
            }
        }
    }
    private func getDistanceWalkingRunning(for timeFrame: TimeFrame) {
        healthKitManager.getDistanceWalkingRunning(forTimeFrame: timeFrame) { distanceWalkingRunning, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.showAlert.toggle()
                    self.error = ErrorDetails(name: "Error", error: error?.localizedDescription ?? "Something Went Wrong")
                    return
                }
                if let distanceWalkingRunning = distanceWalkingRunning {
                    self.activityHealthDataArray.append(UserHealthActivity(data: String(format: "%.1f",distanceWalkingRunning), message: "Lets Travel", image: ImagesController.distanceWalkingRunning.imageName(isGirl: self.isUserGirl), unit: "km", name: "Distance Covered", userHealthType: .distanceWalkingRunning))
                }
            }
        }
    }
    func updateHealthData(for timeFrame: TimeFrame) {
        DispatchQueue.main.async { [self] in
               withAnimation(.easeInOut(duration: 0.5)) {
                   activityHealthDataArray.removeAll()
                   initialize(timeFrame: timeFrame)
                   mainItemView = self.activityHealthDataArray.first ?? UserHealthActivity.MOCK_UserHealthActivity
                   $activityHealthDataArray.sink { userHealthArray in
                       self.mainItemView = userHealthArray.first ?? UserHealthActivity.MOCK_UserHealthActivity
                       self.mainItemProgress = self.checkTheProgress(time: timeFrame, userHealthActivity: self.mainItemView)
                   }.store(in: &cancellables)
               }
           }
    }

}
//MARK: - Challengies
extension HealthViewModel {
    func checkTheProgress(time: TimeFrame, userHealthActivity: UserHealthActivity) -> Double {
        switch userHealthActivity.type {
        case .activeEnergyBurned:
            return activeEnergyBurnedChallengies(time: time, userHealthAcitivityData: userHealthActivity.data)
        case .distanceWalkingRunning:
            return distanceWalkingRunningChallengies(time: time, userHealthAcitivityData: userHealthActivity.data)
        case .heartRate:
            return 0.0
        case .sleepAnalysis:
            return sleepAnalysisChallengies(time: time, userHealthAcitivityData: userHealthActivity.data)
        case .stepCount:
            return stepCountChallengies(time: time, userHealthAcitivityData: userHealthActivity.data)
        }
    }
    private func stepCountChallengies(time: TimeFrame, userHealthAcitivityData: String) -> Double {
        let value = Double(userHealthAcitivityData) ?? 500
        if time == .today {
            return mapValue(value: value, fromRange: 0.0...1000.0, toRange: 0.0...100.0)
        } else if time == .weekly {
            return mapValue(value: value, fromRange: 0.0...10000.0, toRange: 0.0...100.0)
        } else {
            return mapValue(value: value, fromRange: 0.0...50000.0, toRange: 0.0...100.0)
        }
    }
    private func sleepAnalysisChallengies(time: TimeFrame, userHealthAcitivityData: String) -> Double {
        let value = Double(userHealthAcitivityData) ?? 8
        if time == .today {
            return mapValue(value: value, fromRange: 0.0...8.0, toRange: 0.0...100.0)
        } else if time == .weekly {
            return mapValue(value: value, fromRange: 0.0...56.0, toRange: 0.0...100.0)
        } else {
            return mapValue(value: value, fromRange: 0.0...224.0, toRange: 0.0...100.0)
        }
    }
    private func distanceWalkingRunningChallengies(time: TimeFrame, userHealthAcitivityData: String) -> Double {
        let value = Double(userHealthAcitivityData) ?? 1
        if time == .today {
            return mapValue(value: value, fromRange: 0.0...2.3, toRange: 0.0...100.0)
        } else if time == .weekly {
            return mapValue(value: value, fromRange: 0.0...16.0, toRange: 0.0...100.0)
        } else {
            return mapValue(value: value, fromRange: 0.0...65, toRange: 0.0...100.0)
        }
    }
    private func activeEnergyBurnedChallengies(time: TimeFrame, userHealthAcitivityData: String) -> Double {
        let value = Double(userHealthAcitivityData) ?? 150
        if time == .today {
            return mapValue(value: value, fromRange: 0.0...350.0, toRange: 0.0...100.0)
        } else if time == .weekly {
            return mapValue(value: value, fromRange: 0.0...2500.0, toRange: 0.0...100.0)
        } else {
            return mapValue(value: value, fromRange: 0.0...11000.0, toRange: 0.0...100.0)
        }
    }
}
//MARK: - Helper Function
extension HealthViewModel {
    func mapValue(value: Double, fromRange: ClosedRange<Double>, toRange: ClosedRange<Double>) -> Double {
        let normalizedValue = (value - fromRange.lowerBound) / (fromRange.upperBound - fromRange.lowerBound)
        let mappedValue = toRange.lowerBound + normalizedValue * (toRange.upperBound - toRange.lowerBound)
        return min(toRange.upperBound, max(toRange.lowerBound, mappedValue))
    }
}
extension HKHealthStore: ObservableObject{}
