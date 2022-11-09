//
//  WorkoutStruct.swift
//  LiftingLog
//
//  Created by Joseph Melito on 11/9/22.
//

import Foundation

struct Workout: Codable
{
    var date: String
    var workoutType: String
    var weight: Int
    var reps: Int
    var sets: Int
    var comments: String
}
