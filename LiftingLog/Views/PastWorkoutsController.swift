//
//  PastWorkoutsController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/28/22.
//

import UIKit
import SwiftUI

class PastWorkoutsController: UITableViewController {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Past Workouts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(reloadTable))
    }
    
    //shows error if data is not loaded from db
    func showError()
    {
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
    
    @objc func reloadTable()
    {
        //reloads the table data
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let collectionName: String = arrayOfWorkouts[indexPath.row]
        
        DatabaseService().getWorkoutDocumentsFromCollection(collection: collectionName)
        {
            print("DONE")
            let workoutDetails = DetailTableViewController()
            self.navigationController?.pushViewController(workoutDetails, animated: true)
        }
        
    }
}



