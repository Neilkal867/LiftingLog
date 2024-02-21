//
//  WorkoutStruct.swift
//  LiftingLog
//
//  Created by Joseph Melito on 11/9/22.
//

import Foundation

struct Workout: Identifiable {
    var id: String // Add this line
    var date: String
    var workoutType: String
    var weight: Double
    var reps: Double
    var sets: Double
    var comments: String
}

