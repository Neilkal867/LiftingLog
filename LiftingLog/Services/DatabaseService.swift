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
var userProfile: UserProfile?

class DatabaseService: UIViewController
{
    func saveWorkout(workout:Workout)
    {
        let record = CKRecord(recordType: "Workout")
        record["userID"] = userID
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
                   let userid = record["userID"] as? String,
                   let workoutType = record["workoutType"] as? String,
                   let weight = record["weight"] as? Double,
                   let reps = record["reps"] as? Double,
                   let sets = record["sets"] as? Double,
                   let comments = record["comments"] as? String {
                    let workout = Workout(id: userid, date: date, workoutType: workoutType, weight: weight, reps: reps, sets: sets, comments: comments)
                    workouts.append(workout)
                    workoutsArray.append(workout)
                    print(workout)
                }
            }
            completion(workouts, nil)
        }
    }
    
    func createNewUser(profile: UserProfile)
    {
        let record = CKRecord(recordType: "Lifter")
               record["email"] = profile.email
               record["userID"] = userID
               record["sex"] = profile.sex
               record["bodyweight"] = profile.bodyweight
               record["maxBench"] = profile.maxBench
               record["maxSquat"] = profile.maxSquat
               record["maxDeadlift"] = profile.maxDeadlift
               record["maxOHP"] = profile.maxOHP 
        
        privateDB.save(record) { (savedRecord, error) in
            if let error = error
            {
                self.showAlert(title: "Error", message: error.localizedDescription)
                return
            }
        
            print(record)
        }
    }
    
    func loadUserProfile(userID:String)
    {
        
    }
    
    
    func getCurrentMonthDayYear() -> String
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let MonthDayYear = dateFormatter.string(from: date)
        
        return MonthDayYear
    }
    
    func createWorkoutObject(id: String, date: String, workoutType: String, weight: Double, reps: Double, sets: Double, comments: String) -> Workout
    {
        return Workout(id: id, date: date, workoutType: workoutType, weight: weight, reps: reps, sets: sets, comments: comments)
    }
    
    func createUserProfile(email: String,sex: String, bodyweight: Double, maxBench: Double,maxSquat: Double,maxDeadlift: Double,maxOHP: Double ) -> UserProfile
    {
        return UserProfile (
                 email: email,
                 userID: userID!,
                 sex: sex,
                 bodyweight: bodyweight,
                 maxBench: maxBench,
                 maxSquat: maxSquat,
                 maxDeadlift: maxDeadlift,
                 maxOHP: maxOHP
            
        )
    }
    
}
