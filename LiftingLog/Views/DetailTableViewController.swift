//
//  TESTTableViewController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 11/27/22.
//

import UIKit

class DetailTableViewController: UITableViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(reloadTable))
        
        let nib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
       
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return workoutsForDate.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        
        cell.workoutTypeTF.text = workoutsForDate[indexPath.row].workoutType
        cell.weightTF.text = String(workoutsForDate[indexPath.row].weight)
        cell.repsTF.text = String(workoutsForDate[indexPath.row].reps)
        cell.setsTF.text = String(workoutsForDate[indexPath.row].sets)
        cell.commentsTF.text = workoutsForDate[indexPath.row].comments
        
        return cell
    }
    
    @objc func reloadTable()
    {
        //reloads the table data
        self.tableView.reloadData()
    }

}

