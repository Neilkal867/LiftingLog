//
//  WelcomeDashBoardController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 9/27/22.
//

import UIKit

class WelcomeDashBoardController: UITableViewController {
    var welcomeDashOptions = ["Start Workout", "Create Workout", "View Past Workout", "Wilks Calculator", "1RM Calculator", "Settings"]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Welcome to the MainDashboard!"
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return welcomeDashOptions.count
        }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "MainDashTableCells", for: indexPath)
          cell.textLabel?.text = welcomeDashOptions [indexPath.row]
          return cell
      }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5{
            if let settingsCell = storyboard?.instantiateViewController(withIdentifier: "Settings") as? SettingsController{
                navigationController?.pushViewController(settingsCell, animated: true)
            }
        
        }
        
    }

}
