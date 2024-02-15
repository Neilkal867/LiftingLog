//
//  NewWorkoutView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/30/22.
//

import UIKit

class NewWorkoutView: UIViewController {
    
    @IBOutlet weak var workoutTypeTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var numOfRepsTF: UITextField!
    @IBOutlet weak var numOfSetsTF: UITextField!
    @IBOutlet weak var commentsTF: UITextView!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        title = "Log a Pump"
       // navigationItem.setHidesBackButton(true, animated: true)
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.removeKeyboardObserver()
    }
      
    @IBAction func submitNewWorkout(_ sender: Any) {
        submitWorkout()
        self.showAlert(title: "Submitted", message: "Workout Sucessfully Submitted")
        clearTextFields()
    }
    
    func submitWorkout()
    {
        guard let workoutType = workoutTypeTF.text, !workoutType.isEmpty, let weight = weightTF.text, !weight.isEmpty,
              let numofReps = numOfRepsTF.text, !numofReps.isEmpty, let numOfSets = numOfSetsTF.text, !numOfSets.isEmpty
                
        else
        {
            self.showAlert(title: "Required Data", message: "All Fields Must Contain Data. However, Comments Are Optional")
            return
        }
        
   //     let dbService = DatabaseService()
     //   let todaysDate = dbService.getCurrentMonthDayYear()
        let weightInt = Int(weightTF.text!) ?? 0
        let numOfRepsInt = Int(numOfRepsTF.text!) ?? 0
        let numOfSetsInt = Int(numOfSetsTF.text!) ?? 0
        let comments = commentsTF.text ?? ""
    //    let newWorkout = dbService.createWorkoutObject(date: todaysDate, workoutType: workoutType, weight: weightInt, reps: numOfRepsInt, sets: numOfSetsInt, comments: comments)
        
     //   dbService.saveWorkout(workout: newWorkout)
    }
    
    func clearTextFields()
    {
        workoutTypeTF.text = ""
        weightTF.text = ""
        numOfRepsTF.text = ""
        numOfSetsTF.text = ""
        commentsTF.text = ""
    }    
}
