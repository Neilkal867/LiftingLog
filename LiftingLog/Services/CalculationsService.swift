//
//  CalculationsService.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/27/22.
//

import Foundation

class CalculationsService {
    
    init(){}
    
    func calculateMensWilksNumberInPounds() -> Double
    {
        let totalLiftWeightInPounds = GlobalManager.shared.userProfile!.maxBench  + GlobalManager.shared.userProfile!.maxSquat + GlobalManager.shared.userProfile!.maxDeadlift
        let totalLightWeightInKilos = totalLiftWeightInPounds * 0.45359237
        let x = GlobalManager.shared.userProfile!.bodyweight  * 0.45359237
        
        let a = 47.46178854
        let b = 8.472061379
        let c = 0.07369410346
        let d = -0.001395833811
        let e = 7.07665973070743 * 0.000001
        let f = -1.20804336482315 * 0.00000001
        
        let bx = b * x
        let cx = c * pow(x,2)
        let dx = d * pow(x,3)
        let ex = e * pow(x,4)
        let fx = f * pow(x,5)
        
        let bottom = a + bx + cx + dx + ex + fx
        
        let coefficient = 600 / bottom
        let mensWilksNum = coefficient * totalLightWeightInKilos
        return roundToTwoDecimalPlaces(value: mensWilksNum)
    }
    
    func totalLiftInPounds() -> Double
    {
        let totalLiftWeightInPounds = GlobalManager.shared.userProfile!.maxBench  + GlobalManager.shared.userProfile!.maxSquat + GlobalManager.shared.userProfile!.maxDeadlift
        
        return totalLiftWeightInPounds
    }
    
    func totalLiftInKilos() -> Double
    {
        let totalLiftWeightInPounds = GlobalManager.shared.userProfile!.maxBench  + GlobalManager.shared.userProfile!.maxSquat + GlobalManager.shared.userProfile!.maxDeadlift
        
        let totalLiftWeightInKilos = totalLiftWeightInPounds * 0.453592
        
        return totalLiftWeightInKilos
    }
    
    func calculateWomensWilksNumberInPounds(maxBench: Double, maxSquat: Double, maxDeadlift: Double, bodyWeight: Double) -> Double
    {
        let totalLiftWeightInPounds = maxBench + maxSquat + maxDeadlift
        let totalLightWeightInKilos = totalLiftWeightInPounds * 0.45359237
        let x = bodyWeight * 0.45359237
        
        let a = -125.4255398
        let b = 13.71219419
        let c = -0.03307250631
        let d = -0.001050400051
        let e = 9.38773881462799 * 0.000001
        let f = -2.3334613884954 * 0.00000001
        
        let bx = b * x
        let cx = c * pow(x,2)
        let dx = d * pow(x,3)
        let ex = e * pow(x,4)
        let fx = f * pow(x,5)
        
        let bottom = a + bx + cx + dx + ex + fx
        
        let coefficient = 600 / bottom
        let womanWilksNum = coefficient * totalLightWeightInKilos
        return roundToTwoDecimalPlaces(value: womanWilksNum)
    }
    
    func calculateOneRepMax(weight: Double, reps: Double) -> Int
    {
        let repsxweight = weight * reps * 0.0333;
        let repsxweightPlusWeight = repsxweight + weight
        let oneRepMax = Int(ceil(repsxweightPlusWeight))
        return oneRepMax;
    }
    
    func roundToTwoDecimalPlaces(value: Double) -> Double {
        let roundedValue = (value * 100).rounded() / 100
        return roundedValue
    }
    
    
  // Warmup workouts
    
    func warmUpOne(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.4)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    func warmUpTwo(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.5)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    func warmUpThree(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.6)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    // Week one workouts
    
    func weekOneFirst(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.65)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
   func weekOneSecond(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.75)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    func weekOneThird(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.85)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    // Week Two workous
    
    func weekTwoFirst(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.7)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    func weekTwoSecond(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.8)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    func weekTwoThird(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.9)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    // Week Three Workouts
    
    func weekThreeFirst(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.75)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    func weekThreeSecond(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.85)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
    
    func weekThreeThird(workoutWeight: Double) -> Int
    {
        var warmup = workoutWeight * 0.9
        warmup = round(warmup / 5) * 5
        
        warmup = (workoutWeight * 0.95)
        warmup = round(warmup / 5) * 5
        return Int(warmup)
    }
}
