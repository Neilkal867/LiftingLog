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
        record["userID"] = GlobalManager.shared.userID
       // record["workoutID"] = record.recordID.recordName
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
        }
        GlobalManager.shared.workoutArray.append(workout)
        print(workout)
        print(GlobalManager.shared.workoutArray)
    }
    
    static func loadWorkouts() {
            let predicate = NSPredicate(format: "userID == %@", GlobalManager.shared.userID ?? "")
            let query = CKQuery(recordType: "Workout", predicate: predicate)
            privateDB.perform(query, inZoneWith: nil) { (records, error) in
                if let error = error {
                    // Handle error appropriately
                   print("Error loading workouts: \(error.localizedDescription)")
                    return
                }
                
                var workouts: [Workout] = []
                records?.forEach { record in
                   let workoutID = record["workoutID"] as? String
                    if let date = record["date"] as? String,
                       let workoutType = record["workoutType"] as? String,
                       let weight = record["weight"] as? Double,
                       let reps = record["reps"] as? Double,
                       let sets = record["sets"] as? Double,
                       let comments = record["comments"] as? String {
                        workouts.append(Workout(id: GlobalManager.shared.userID!, date: date, workoutType: workoutType, weight: weight, reps: reps, sets: sets, comments: comments))
                       
                    }
                }
                
                DispatchQueue.main.async {
                    GlobalManager.shared.workoutArray = workouts
                }
            }
        }
    
    func createNewUser(profile: UserProfile)
    {
        let record = CKRecord(recordType: "Lifter")
        record["email"] = profile.email
        record["userID"] = GlobalManager.shared.userID
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
   
    func loadUserProfile(userID: String) {
        let predicate = NSPredicate(format: "userID == %@", userID)
        let query = CKQuery(recordType: "Lifter", predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let record = records?.first else {
                print("No record found for the given userID.")
                return
            }
            
            var userProfile = UserProfile(
                email: record["email"] as? String ?? "",
                userID: userID,
                sex: record["sex"] as? String ?? "",
                bodyweight: record["bodyweight"] as? Double ?? 0,
                maxBench: record["maxBench"] as? Double ?? 0,
                maxSquat: record["maxSquat"] as? Double ?? 0,
                maxDeadlift: record["maxDeadlift"] as? Double ?? 0,
                maxOHP: record["maxOHP"] as? Double ?? 0
            )
            
            // Update the global userProfile
            GlobalManager.shared.userProfile = userProfile
        }
    }
    
    func getCurrentMonthDayYear() -> String
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"//HH:mm:ss"
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
            userID: GlobalManager.shared.userID!,
            sex: sex,
            bodyweight: bodyweight,
            maxBench: maxBench,
            maxSquat: maxSquat,
            maxDeadlift: maxDeadlift,
            maxOHP: maxOHP
            
        )
    }
}
