//
//  DatabaseService.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 10/27/22.
//

import CloudKit
import Foundation
import UIKit

let container = CKContainer.default()
let privateDB = container.privateCloudDatabase

class DatabaseService: UIViewController
{
    func saveWorkout(workout:Workout)
    {
        
        let record = CKRecord(recordType: "Workout")
        record["date"] = workout.date
        record["workoutType"] = workout.workoutType
        record["weight"] = workout.weight
        record["reps"] = workout.reps
        record["sets"] = workout.sets
        record["comments"] = workout.comments
        
        privateDB.save(record) { (savedRecord, error) in
            if let error = error {
                // Handle the error here
                
                self.showAlert(title: "Error", message: error.localizedDescription)
                return
            }
            // Handle the successful save here
            self.showAlert(title: "Submitted", message: "Workout Sucessfully Submitted SAVE WORKOUT")
        }
        
    }
    
    func getCurrentMonthDayYear() -> String
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let MonthDayYear = dateFormatter.string(from: date)
        
        return MonthDayYear
    }
    
    func createWorkoutObject(date: String, workoutType: String, weight: Double, reps: Double, sets: Double, comments: String) -> Workout
    {
        return Workout(date: date, workoutType: workoutType, weight: weight, reps: reps, sets: sets, comments: comments)
    }
    
}

