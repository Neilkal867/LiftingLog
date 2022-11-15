//
//  DatabaseService.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 10/27/22.
//
import FirebaseFirestore
import Foundation
import Firebase

var arrayOfWorkouts = [String]()

class DatabaseService
{
    init(){}
    
    let workoutCollection: String = "Workouts"
    
    func saveWorkout(workout:Workout)
    {
        let db = Firestore.firestore()
        
        let todaysDate:String = getCurrentMonthDayYear()
        
        db.collection(todaysDate).addDocument(data: [
            "Workout Type" : workout.workoutType,
            "Reps" : workout.reps,
            "Sets" : workout.sets,
            "Weight" : workout.weight,
            "Comments": workout.comments
        ])
        
        addDateToWorkoutCollection(date: todaysDate)
    }
    
    //I think this method can be used to grab the individual workout when the user clicks one from the lists of dates
    func loadSpecificWorkout(){}
    
    //I think this method will grab all collections in the DB
    func getAllCollections(completion: @escaping([QueryDocumentSnapshot]) -> Void)
    {
        let db = Firestore.firestore()
        
        db.collection(workoutCollection).getDocuments()
        { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else
            {
                completion(snapshot!.documents)
            }
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
    
    func createWorkoutObject(date: String, workoutType: String, weight: Int, reps: Int, sets: Int, comments: String) -> Workout
    {
        return Workout(date: date, workoutType: workoutType, weight: weight, reps: reps, sets: sets, comments: comments)
    }
    
    func addDateToWorkoutCollection(date: String)
    {
        let db = Firestore.firestore()
        
        db.collection(workoutCollection).document(date).setData(["field":""])
    }
    
    func intalizeWorkoutsArray()
    {
        getAllCollections
        { documents in
            for document in documents
            {
                arrayOfWorkouts.append(document.documentID)
            }
        }
    }
}
