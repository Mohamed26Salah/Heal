//
//  Challenge.swift
//  Heal
//
//  Created by Mohamed Salah on 09/10/2023.
//

import Foundation

struct Challenge {
    let title: String
    let todayRange: ClosedRange<Double>
    let weeklyRange: ClosedRange<Double>
    let monthlyRange: ClosedRange<Double>
}

class ChallengeManager {
    static let shared = ChallengeManager()
    
    let stepCountChallenge = Challenge(
        title: "Step Count",
        todayRange: 0.0...1000.0,
        weeklyRange: 0.0...10000.0,
        monthlyRange: 0.0...50000.0
    )
    
    let sleepAnalysisChallenge = Challenge(
        title: "Sleep Analysis",
        todayRange: 0.0...8.0,
        weeklyRange: 0.0...56.0,
        monthlyRange: 0.0...224.0
    )
    
    let distanceWalkingRunningChallenge = Challenge(
        title: "Distance Walking/Running",
        todayRange: 0.0...2.3,
        weeklyRange: 0.0...16.0,
        monthlyRange: 0.0...65.0
    )
    
    let activeEnergyBurnedChallenge = Challenge(
        title: "Active Energy Burned",
        todayRange: 0.0...350.0,
        weeklyRange: 0.0...2500.0,
        monthlyRange: 0.0...11000.0
    )
        
    private init() {}
}
