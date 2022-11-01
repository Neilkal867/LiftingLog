//
//  NewWorkoutView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/30/22.
//

import UIKit

class NewWorkoutView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New Workout"
        navigationItem.setHidesBackButton(true, animated: true)
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.addKeyboardObserver()
       }

       override func viewWillDisappear(_ animated: Bool) {
           self.removeKeyboardObserver()
       }

    @IBAction func cancelNewWorkout(_ sender: UIButton) {
        self.showCancelAlert(title: "Cancel Workout", message: "Are You Sure You Want To Cancel Workout? All Data Will Be Lost.")
    }

    @IBAction func submitNewWorkout(_ sender: UIButton) {
        self.showAlert(title: "Submitted", message: "Workout Successfully Submitted!")
    }
   
}
