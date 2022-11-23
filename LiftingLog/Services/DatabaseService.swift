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
var workouts = [Workout]()

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
    func getDocumentIdsForCollection(collection: String)
    {
        let db = Firestore.firestore()
        
        db.collection(collection).getDocuments { documents, error in
            if (error != nil)
            {
                print(error!.localizedDescription)
            }
            
            for doc in documents!.documents
            {
                self.getWorkoutFromDocumentId(collection: collection, workoutId: doc.documentID)
            }
        }
    }
    
    func getWorkoutFromDocumentId(collection: String, workoutId: String)
    {
        let db = Firestore.firestore()
        
        db.collection(collection).getDocuments { snapshot, error in
            if error == nil
            {
                if let snapshot = snapshot
                {
                    workouts = snapshot.documents.map { d in
                        
                        return Workout(date: collection,workoutType: d["Workout Type"] as? String  ?? "",weight: d["Weight"] as? Int  ?? 0,reps: d["Reps"] as? Int  ?? 0,sets: d["Sets"] as? Int  ?? 0,comments: d["Comments"] as? String  ?? "")
                    
                    }
                
                }
                print(workouts)
            }
            
            else
            {
                print(error)
            }
        }
    }
    
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
