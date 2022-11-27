//
//  PastWorkoutsController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/28/22.
//

import UIKit
import SwiftUI

var workoutTypePerDay = 0
var workout = [Workout]()
class PastWorkoutsController: UITableViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Past Workouts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(reloadTable))
    }
    //shows error if data is not loaded from db
    func showError(){
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the data. Please refresh and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title:"OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // returns individual indexs of the array to our table view
        return arrayOfWorkouts.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //takes the values of the corrosponding index of the array and assigns it to the text of the table view cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastWorkoutCells", for: indexPath)
        cell.textLabel?.text = arrayOfWorkouts[indexPath.row]
        return cell
    }
    
    @objc func reloadTable() {
        //reloads the table data
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //  let collectionName: String = arrayOfWorkouts[indexPath.row]
        //  DatabaseService().getWorkoutDocumentsFromCollection(collection: collectionName)
        let workoutDetails = TESTTableViewController()
        
        for w in workouts
        {
            workoutDetails.workoutItem?.workoutType = "test"//w.workoutType
            workoutDetails.workoutItem?.weight = 100 //w.weight
            workoutDetails.workoutItem?.sets = 100//w.sets
            workoutDetails.workoutItem?.reps = 100//w.reps
            workoutDetails.workoutItem?.comments = "strong"//w.comments
            //            workout.append(Workout(date: "\(w.date)", workoutType: "\(w.weight)", weight: w.weight, reps: w.reps, sets: w.sets, comments: "\(w.comments)"))
            workout.append(Workout(date: "Todays DATE", workoutType: "\(workoutDetails.workoutItem?.workoutType ?? "")", weight: workoutDetails.workoutItem?.weight ?? 00, reps: workoutDetails.workoutItem?.reps ?? 00, sets: workoutDetails.workoutItem?.sets ?? 00, comments: "\(workoutDetails.workoutItem?.comments ?? "")"))
            workoutTypePerDay+=1
        }
            navigationController?.pushViewController(workoutDetails, animated: true)
            
            // here is where i have the entire array now for each through it and display everything on the detail view
            // let vc = DetailViewController()
            // vc.workoutItem = workouts[indexPath.row]
            //  navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    

