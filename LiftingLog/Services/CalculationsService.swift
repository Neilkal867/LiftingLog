//
//  CalculationsService.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/27/22.
//

import Foundation

class CalculationsService {
    
    init(){}

    func calculateMensWilksNumberInPounds(maxBench: Double, maxSquat: Double, maxDeadlift: Double, bodyWeight: Double) -> Double
    {
        let totalLiftWeightInPounds = maxBench + maxSquat + maxDeadlift
        let totalLightWeightInKilos = totalLiftWeightInPounds * 0.45359237
        let x = bodyWeight * 0.45359237
        
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
        return coefficient * totalLightWeightInKilos
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
        return coefficient * totalLightWeightInKilos
    }

    func calculateOneRepMax(weight: Double, reps: Double) -> Int
    {
        let repsxweight = weight * reps * 0.0333;
        let repsxweightPlusWeight = repsxweight + weight
        let oneRepMax = Int(ceil(repsxweightPlusWeight))
        return oneRepMax;
    }

}
