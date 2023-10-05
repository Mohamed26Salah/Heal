//
//  HealthKitManager.swift
//  Heal
//
//  Created by Mohamed Salah on 04/10/2023.
//

import Foundation
import HealthKit

import HealthKit

enum TimeFrame: String {
    case today
    case daily
    case weekly
    case monthly
}
protocol HealthKitManaging {
    // Function to retrieve age, biological sex, and blood type
    func getAgeSexAndBloodType() throws -> (age: Int, biologicalSex: HKBiologicalSex, bloodType: HKBloodType)

    // Function to retrieve the most recent sample for a given sample type
    func getMostRecentSample(for sampleType: HKSampleType, completion: @escaping (HKQuantitySample?, Error?) -> Void)

    // Function to retrieve step count for a specified time frame
    func getStepCount(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void)

    // Function to retrieve active energy burned for a specified time frame
    func getActiveEnergyBurned(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void)

    // Function to retrieve sleep analysis for a specified time frame
    func getSleepAnalysis(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void)

    // Function to retrieve distance walked or run for a specified time frame
    func getDistanceWalkingRunning(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void)

    // Function to retrieve average heart rate for a specified time frame
    func getAverageHeartRate(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void)
}

class HealthKitManager: HealthKitManaging {
    
    private let healthStore = HKHealthStore()

    func getAgeSexAndBloodType() throws -> (age: Int, biologicalSex: HKBiologicalSex, bloodType: HKBloodType) {
        do {
            let birthdayComponents =  try self.healthStore.dateOfBirthComponents()
            let biologicalSex =       try self.healthStore.biologicalSex()
            let bloodType =           try self.healthStore.bloodType()
            let age = calculateAge(birthdayComponents: birthdayComponents)
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            let unwrappedBloodType = bloodType.bloodType
            
            return (age, unwrappedBiologicalSex, unwrappedBloodType)
        }
    }
    class func getAgeSexAndBloodType() throws -> (age: Int,
                                                  biologicalSex: HKBiologicalSex,
                                                  bloodType: HKBloodType) {
        
      let healthKitStore = HKHealthStore()
        
      do {

        //1. This method throws an error if these data are not available.
        let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
        let biologicalSex =       try healthKitStore.biologicalSex()
        let bloodType =           try healthKitStore.bloodType()
          
        //2. Use Calendar to calculate age.
        let today = Date()
        let calendar = Calendar.current
        let todayDateComponents = calendar.dateComponents([.year],
                                                            from: today)
        let thisYear = todayDateComponents.year!
        let age = thisYear - birthdayComponents.year!
         
        //3. Unwrap the wrappers to get the underlying enum values.
        let unwrappedBiologicalSex = biologicalSex.biologicalSex
        let unwrappedBloodType = bloodType.bloodType
          
        return (age, unwrappedBiologicalSex, unwrappedBloodType)
      }
    }

    func getMostRecentSample(for sampleType: HKSampleType, completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
        
        //1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            DispatchQueue.main.async {
                guard let samples = samples,
                      let mostRecentSample = samples.first as? HKQuantitySample else {
                    
                    completion(nil, error)
                    return
                }
                completion(mostRecentSample, nil)
            }
        }
        healthStore.execute(sampleQuery)
    }
    func getStepCount(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void) {
        let sampleType = HKSampleType.quantityType(forIdentifier: .stepCount)!
        var predicate: NSPredicate
        predicate = getPredicate(forTimeFrame: timeFrame)
        
        let query = HKStatisticsQuery(quantityType: sampleType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { query, result, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let sum = result?.sumQuantity() {
                let steps = sum.doubleValue(for: HKUnit.count())
                completion(steps, nil)
            } else {
                completion(nil, nil)
            }
        }
        
        healthStore.execute(query)
    }
    func getActiveEnergyBurned(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void) {
        let sampleType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        var predicate: NSPredicate
        predicate = getPredicate(forTimeFrame: timeFrame)

        let query = HKStatisticsQuery(quantityType: sampleType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { query, result, error in
            if let error = error {
                completion(nil, error)
                return
            }

            if let sum = result?.sumQuantity() {
                let energyBurned = sum.doubleValue(for: HKUnit.kilocalorie())
                completion(energyBurned, nil)
            } else {
                completion(nil, nil)
            }
        }

        healthStore.execute(query)
    }
    func getSleepAnalysis(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void) {
        let sampleType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let predicate = getPredicate(forTimeFrame: timeFrame)

        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil) { query, results, error in
            if let error = error {
                completion(nil, error)
                return
            }

            var totalSleepTime = 0.0

            if let results = results {
                for result in results {
                    if let result = result as? HKCategorySample{
                        totalSleepTime += result.endDate.timeIntervalSince(result.startDate)
                    }
                }
            }

            // Convert total sleep time to hours
            let totalSleepTimeInHours = totalSleepTime / 3600
            completion(totalSleepTimeInHours, nil)
        }

        healthStore.execute(query)
    }
    func getDistanceWalkingRunning(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void) {
        let sampleType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let predicate = getPredicate(forTimeFrame: timeFrame)

        let query = HKStatisticsQuery(quantityType: sampleType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { query, result, error in
            if let error = error {
                completion(nil, error)
                return
            }

            if let sum = result?.sumQuantity() {
                let distanceInMeters = sum.doubleValue(for: HKUnit.meter())
                var distanceInKilometers = distanceInMeters / 1000.0
                distanceInKilometers = (distanceInKilometers * 100).rounded() / 100
                completion(distanceInKilometers, nil)
            } else {
                completion(nil, nil) // No distance data available for the specified period
            }
        }

        healthStore.execute(query)
    }

    func getAverageHeartRate(forTimeFrame timeFrame: TimeFrame, completion: @escaping (Double?, Error?) -> Void) {
        let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let predicate = getPredicate(forTimeFrame: timeFrame)

        let query = HKStatisticsQuery(quantityType: sampleType,
                                      quantitySamplePredicate: predicate,
                                      options: .discreteAverage) { query, result, error in
            if let error = error {
                completion(nil, error)
                return
            }

            if let average = result?.averageQuantity() {
                let heartRate = average.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                completion(heartRate, nil)
            } else {
                completion(nil, nil) // No heart rate data available for the specified period
            }
        }

        healthStore.execute(query)
    }

}
//MARK: Helper Functions
extension HealthKitManager {
    private func calculateAge(birthdayComponents: DateComponents) -> Int {
        let today = Date()
        let calendar = Calendar.current
        let todayDateComponents = calendar.dateComponents([.year],
                                                          from: today)
        let thisYear = todayDateComponents.year!
        return thisYear - birthdayComponents.year!
    }
    func getTodayPredicate() -> NSPredicate {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        return predicate
    }
    func get24hPredicate() ->  NSPredicate{
        let today = Date()
        let startDate = Calendar.current.date(byAdding: .hour, value: -24, to: today)
        let predicate = HKQuery.predicateForSamples(withStart: startDate,end: today,options: [])
        return predicate
    }
    func getWeeklyPredicate() -> NSPredicate {
        let today = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -7, to: today)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: today, options: [])
        return predicate
    }
    func getMonthlyPredicate() -> NSPredicate {
        let today = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .month, value: -1, to: today)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: today, options: [])
        return predicate
    }
    func getPredicate(forTimeFrame timeFrame: TimeFrame) -> NSPredicate {
        switch timeFrame {
        case .today:
            return getTodayPredicate()
        case .daily:
            return get24hPredicate()
        case .weekly:
            return getWeeklyPredicate()
        case .monthly:
            return getMonthlyPredicate()
        }
    }

}
