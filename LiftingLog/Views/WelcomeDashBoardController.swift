//
//  WelcomeDashBoardController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 9/27/22.
//

import UIKit

class WelcomeDashBoardController: UITableViewController {
    
    var welcomeDashOptions = ["My Profile","New Workout", "View Past Workout", "Wilks Calculator", "1RM Calculator", "Lifting Buddy"]
    
   // let db = DatabaseService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Pump Path!"
        navigationItem.setHidesBackButton(true, animated: true)
    //   db.intalizeDateArray()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return welcomeDashOptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainDashTableCells", for: indexPath)
        cell.textLabel?.text = welcomeDashOptions [indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == welcomeDashOptions.firstIndex(of: "My Profile"){
            navigateToSwiftUIView {UserProfileView()}
        }
        
        if indexPath.row == welcomeDashOptions.firstIndex(of: "New Workout"){
            navigateToSwiftUIView {NewWorkoutView()}
        
        }
        
      /*  if indexPath.row == welcomeDashOptions.firstIndex(of: "View Past Workout"){
            mainDashUIVC(vcToDisplay: "PastWorkouts", viewController: PastWorkoutsController.self)
        }*/
        
        if indexPath.row == welcomeDashOptions.firstIndex(of: "Wilks Calculator"){
            navigateToSwiftUIView {WilksCalculatorView()}
        }
        
        if indexPath.row == welcomeDashOptions.firstIndex(of: "1RM Calculator"){
            navigateToSwiftUIView {OneRMCalculatorView()}
        }
        
        if indexPath.row == welcomeDashOptions.firstIndex(of: "Lifting Buddy"){
            navigateToSwiftUIView {LiftingBuddyView()}
        }
        
    
        
    }
}
