//
//  WorkoutStruct.swift
//  LiftingLog
//
//  Created by Joseph Melito on 11/9/22.
//

import Foundation

struct Workout {
    var id: String 
    var date: String
    var workoutType: String
    var weight: Double
    var reps: Double
    var sets: Double
    var comments: String
}

struct UserProfile {
    var email: String
    var userID: String
    var sex: String
    var bodyweight: Double
    var maxBench: Double
    var maxSquat: Double
    var maxDeadlift: Double
    var maxOHP: Double
}

struct Authresponse
{
    var SuccesfulSignin: Bool
    var Error: String
}


