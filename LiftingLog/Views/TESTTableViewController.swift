//
//  TESTTableViewController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 11/27/22.
//

import UIKit

class TESTTableViewController: UITableViewController {
    var workoutItem: Workout?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.workoutTypeTF.text = workoutItem?.workoutType
            cell.weightTF.text = "\(workoutItem?.weight ?? 00)"
            cell.repsTF.text = "\(workoutItem?.reps ?? 00)"
            cell.setsTF.text = "\(workoutItem?.sets ?? 00)"
            cell.commentsTF.text = workoutItem?.comments
        return cell
    }

}
