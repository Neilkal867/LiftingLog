//
//  PastWorkoutsController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/28/22.
//

import UIKit
import SwiftUI

class PastWorkoutsController: UITableViewController {
    var workout = [Workout]()
    var filteredWorkouts = [Workout]()
    var filterKeyword: String = ""
   
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
            title = "Past Workouts"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(askFilter))
//        workout.append(Workout(date: "November-11-2022", workoutType: "Lift1", weight: 100, reps: 100, sets: 100, comments: "comment1"))
//        workout.append(Workout(date: "November-12-2022", workoutType: "Lift2", weight: 200, reps: 200, sets: 200, comments: "comment2"))
//        workout.append(Workout(date: "November-13-2022", workoutType: "Lift3", weight: 300, reps: 300, sets: 300, comments: "comment3"))
    }
    //shows error if data is not loaded from db
//    func showError(){
//        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the data. Please refresh and try again.", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title:"OK", style: .default))
//            present(ac, animated: true)
//        }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfWorkouts.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print(indexPath)
          let cell = tableView.dequeueReusableCell(withIdentifier: "PastWorkoutCells", for: indexPath)
          cell.textLabel?.text = arrayOfWorkouts[indexPath.row]
          return cell
    }

    
//
//    @objc func askFilter() {
//            let ac = UIAlertController(title: "Filter", message: "Filter the petitions on the following keyword (leave empty to reset filtering)", preferredStyle: .alert)
//            ac.addTextField()
//
//            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            ac.addAction(UIAlertAction(title: "OK", style: .default) {
//                [weak self, weak ac] _ in
//                self?.filterKeyword = ac?.textFields?[0].text ?? ""
//                self?.filterData()
//                self?.tableView.reloadData()
//            })
//
//            present(ac, animated: true)
//
//        }
//
//    func filterData() {
//           if filterKeyword.isEmpty {
//               filteredWorkouts = workout
//               navigationItem.leftBarButtonItem?.title = "Filter"
//               return
//           }
//        navigationItem.leftBarButtonItem?.title = "Filter (current: \(filterKeyword))"
//        filteredWorkouts = workout.filter() { workout in
//            if let _ = workout.date.range(of: filterKeyword, options: .caseInsensitive) {
//                   return true
//               }
//               if let _ =  workout.date.range(of: filterKeyword, options: .caseInsensitive) {
//                   return true
//               }
//               return false
//           }
//       }
//

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        filterData()
//       // tableView.reloadData()
//        return filteredWorkouts.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PastWorkoutCells", for: indexPath)
//        let workout = filteredWorkouts[indexPath.row]
//        cell.textLabel?.text = workout.date
//        return cell
//    }
//
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
      
        DatabaseService().getDocumentIdsForCollection(collection: arrayOfWorkouts[indexPath.row])
        
        //let vc = DetailViewController() // new detail view controller that will need to be created to format what insdie each cell looks like
                // look at hacking with swift project 7
       //vc.workoutItem = workout[indexPath.row]
        //navigationController?.pushViewController(vc, animated: true)
    }
}


