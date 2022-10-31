//
//  OneRMCalculatorViewController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/28/22.
//

import UIKit

class OneRMCalculatorViewController: UIViewController {
    var calcServ = CalculationsService()
    @IBOutlet weak var bodyWeightRMTF: UITextField!
    @IBOutlet weak var numberOfRepsRMTF: UITextField!
    @IBOutlet weak var calc1RMButton: UIButton!
    @IBOutlet weak var oneRMOutputTF: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "1RM Calculator"
        self.hideKeyboardWhenTappedAround()
    }


    @IBAction func calculateRM(_ sender: UIButton) {
        
        guard let bodyWeight = bodyWeightRMTF.text, !bodyWeight.isEmpty, let numOfReps = numberOfRepsRMTF.text, !numOfReps.isEmpty else{
            showAlert(title: "Blank Values", message: "Bodyweight & Number of Reps Cannot Be Left Blank")
            return
      }
            let doubleBodyWeight = Double(bodyWeightRMTF.text!) ?? 0.0
            let doubleNumberOfReps = Double(numberOfRepsRMTF.text!) ?? 0.0
            let rmCalc = calcServ.calculateOneRepMax(weight: doubleBodyWeight, reps: doubleNumberOfReps)
           
           oneRMOutputTF.text = String(rmCalc)
    }
}
