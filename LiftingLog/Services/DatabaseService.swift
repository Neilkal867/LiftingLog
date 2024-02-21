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
var workoutsArray = [Workout]()

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
            if let error = error
            {
                self.showAlert(title: "Error", message: error.localizedDescription)
                return
            }
            // Handle the successful save here
        }
    }
    
    func loadWorkouts(completion: @escaping ([Workout]?, Error?) -> Void) {
        let query = CKQuery(recordType: "Workout", predicate: NSPredicate(value: true))
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            guard error == nil else
            {
                completion(nil, error)
                return
            }
            
            var workouts = [Workout]()
            records?.forEach { record in
                if let date = record["date"] as? String,
                   let workoutType = record["workoutType"] as? String,
                   let weight = record["weight"] as? Double,
                   let reps = record["reps"] as? Double,
                   let sets = record["sets"] as? Double,
                   let comments = record["comments"] as? String {
                    let workout = Workout(date: date, workoutType: workoutType, weight: weight, reps: reps, sets: sets, comments: comments)
                    workouts.append(workout)
                    workoutsArray.append(workout)
                }
            }
            completion(workouts, nil)
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
