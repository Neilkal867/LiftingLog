//
//  DatabaseService.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 10/27/22.
//
import FirebaseFirestore
import Foundation
import Firebase

class DatabaseService
{
    
    struct Workout
    {
        var date: String
        var workoutTitle: String
        var workout: String
        var weight: Int
        var reps: Int
        var sets: Int
        var comments: String
    }
    
    init(){}

    func saveWorkout(workout:Workout)
    {
        let db = Firestore.firestore()
        
        let todaysDate:String = getCurrentMonthDayYear()

        db.collection(todaysDate).addDocument(data: [
            "Lift" : workout.workoutTitle,
            "Reps" : workout.reps,
            "Weight" : workout.weight,
            "Comments": workout.comments
        ])
    }
    
    //I think this method can be used to grab the individual workout when the user clicks one from the lists of dates
    func loadSpecificWorkout(){}
    
    //I think this method will grab all collections in the DB
    func loadAllWorkouts(){}
    
    func getCurrentMonthDayYear() -> String
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let MonthDayYear = dateFormatter.string(from: date)
        
        return MonthDayYear
    }
    
    func createWorkoutObject(date: String, workoutTitle: String, workout: String, weight: Int, reps: Int, sets: Int, comments: String) -> Workout
    {
        return Workout(date: date, workoutTitle: workoutTitle,workout: workout,weight: weight,reps: reps,sets: sets,comments: comments)
    }
}
