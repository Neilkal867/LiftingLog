//
//  PastWorkoutsController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/28/22.
//

import UIKit
import SwiftUI
/*
var workoutsForDate = [Workout]()

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
        //return dateArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //takes the values of the corrosponding index of the array and assigns it to the text of the table view cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastWorkoutCells", for: indexPath)
            
      //  let date:String = dateArray[indexPath.row].date
        
        cell.textLabel?.text = date
        
        return cell
    }
    
    @objc func reloadTable()
    {
        //reloads the table data
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let clickedDate: String = dateArray[indexPath.row].date
        
        getWorkoutsArrayForSpecificDate(clickedDate: clickedDate)
       
        let workoutDetails = DetailTableViewController()
        self.navigationController?.pushViewController(workoutDetails, animated: true)
    }
    
    func getWorkoutsArrayForSpecificDate(clickedDate: String)
    {
        workoutsForDate.removeAll()
      //  for w in workouts
      //  {
      //      if (w.date == clickedDate)
       //     {
        //        workoutsForDate.append(w)
        //    }
       // }
    }
}



*/
