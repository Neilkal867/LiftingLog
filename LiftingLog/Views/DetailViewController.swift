//
//  DetailViewController.swift
//  Project7
//
//  Created by Joseph Melito on 10/7/22.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var workoutItem: Workout?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return workoutTypePerDay
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.workoutTypeTF.text = workoutItem?.workoutType
            cell.weightTF.text = "\(workoutItem?.weight ?? 00)"
            cell.repsTF.text = "\(workoutItem?.reps ?? 00)"
            cell.setsTF.text = "\(workoutItem?.sets ?? 00)"
            cell.commentsTF.text = workoutItem?.comments
        return cell
    }
}
