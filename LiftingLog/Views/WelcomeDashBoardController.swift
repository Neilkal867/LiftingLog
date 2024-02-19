//
//  WelcomeDashBoardController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 9/27/22.
//

import UIKit

class WelcomeDashBoardController: UITableViewController {
    
    var welcomeDashOptions = ["Log a Workout", "View Past Workout", "Wilks Calculator", "1RM Calculator", "Settings", "Lifting Buddy"]
    
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
        if indexPath.row == welcomeDashOptions.firstIndex(of: "Log a Workout"){
            navigateToUIKitView(vcToDisplay: "NewWorkout", viewController: NewWorkoutView.self)
        }
        
      /*  if indexPath.row == welcomeDashOptions.firstIndex(of: "View Past Workout"){
            mainDashUIVC(vcToDisplay: "PastWorkouts", viewController: PastWorkoutsController.self)
        }*/
        
        if indexPath.row == welcomeDashOptions.firstIndex(of: "Wilks Calculator"){
            navigateToUIKitView(vcToDisplay: "WilksCalc", viewController: WilksCalculatorController.self)
        }
        
        if indexPath.row == welcomeDashOptions.firstIndex(of: "1RM Calculator"){
            navigateToUIKitView(vcToDisplay: "1RMCalc", viewController: OneRMCalculatorViewController.self )
        }
        
        if indexPath.row == welcomeDashOptions.firstIndex(of: "Settings"){
            navigateToUIKitView(vcToDisplay: "Settings", viewController: SettingsController.self)
        }
        if indexPath.row == welcomeDashOptions.firstIndex(of: "Lifting Buddy"){
            navigateToSwiftUIView {ChatView()}
            //vcToDisplay: "Settings", viewController: SettingsController.self)
        }
        
    
        
    }
}
