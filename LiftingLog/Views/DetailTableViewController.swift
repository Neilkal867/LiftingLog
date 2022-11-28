//
//  TESTTableViewController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 11/27/22.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var workoutItem: Workout?
    var workoutTypeArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(reloadTable))
        
        let nib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        var indexArray = 0
        while (workouts.count > indexArray){
            for w in workouts
            {
                workoutItem?.workoutType = w.workoutType
                workoutItem?.weight = w.weight
                workoutItem?.sets = w.sets
                workoutItem?.reps = w.reps
                workoutItem?.comments = w.comments
                
                cell.workoutTypeTF.text = workoutItem?.workoutType ?? "No Workout"//"\(workouts[workouts.count].workoutType)"
                cell.weightTF.text = "\(workoutItem?.weight ?? 00)"
                cell.repsTF.text = "\(workoutItem?.reps ?? 00)"
                cell.setsTF.text = "\(workoutItem?.sets ?? 00)"
                cell.commentsTF.text = workoutItem?.comments ?? "No Comments"
                indexArray+=1
                break
                //            workout.append(Workout(date: "\(workoutItem?.date ?? "No Date")",
                //                                   workoutType: "\(workoutItem?.workoutType ?? "No Workout")",
                //                                   weight: workoutItem?.weight ?? 00,
                //                                   reps: workoutItem?.reps ?? 00,
                //                                   sets: workoutItem?.sets ?? 00,
                //                                   comments: "\(workoutItem?.comments ?? "No Comments")"))
            }
        }
        
//            cell.workoutTypeTF.text = workoutItem?.workoutType ?? "No Workout"//"\(workouts[workouts.count].workoutType)"
//            cell.weightTF.text = "\(workoutItem?.weight ?? 00)"
//            cell.repsTF.text = "\(workoutItem?.reps ?? 00)"
//            cell.setsTF.text = "\(workoutItem?.sets ?? 00)"
//            cell.commentsTF.text = workoutItem?.comments ?? "No Comments"
//            indexArray+=1
        print(cell.workoutTypeTF.text as Any)
        return cell
        
    }
    
    @objc func reloadTable() {
        //reloads the table data
        self.tableView.reloadData()
    }

}
