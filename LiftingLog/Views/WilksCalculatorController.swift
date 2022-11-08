//
//  WilksCalculatorController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/28/22.
//

import UIKit

class WilksCalculatorController: UIViewController {

    var genderValue: String = ""
    var calcServ = CalculationsService()
    @IBOutlet weak var bodyWeightTF: UITextField!
    @IBOutlet weak var maxBenchTF: UITextField!
    @IBOutlet weak var maxSquatTF: UITextField!
    @IBOutlet weak var maxDeadLiftTF: UITextField!
    @IBOutlet weak var calcWilksButton: UIButton!
    @IBOutlet weak var wilksScoreTF: UITextField!
    @IBOutlet weak var genderSelection: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Wilks Calculator"
        self.hideKeyboardWhenTappedAround()
        genderValue = "Male"

    }
    
    
    
    @IBAction func calculateWilksButton(_ sender: UIButton) {
        guard let bodyWeight = bodyWeightTF.text, !bodyWeight.isEmpty, let maxBench = maxBenchTF.text, !maxBench.isEmpty,
              let maxSquat = maxSquatTF.text, !maxSquat.isEmpty, let maxDeadLift = maxDeadLiftTF.text, !maxDeadLift.isEmpty
        else{
            showAlert(title: "Blank Values", message: "Bodyweight, Max Bench, Max Squat, & Max Deadlift Cannot Be Left Blank")
            return
        }
        
        let doubleBodyWeight = Double(bodyWeightTF.text!) ?? 0.0
        let doubleMaxBench = Double(maxBenchTF.text!) ?? 0.0
        let doubleMaxSquat = Double(maxSquatTF.text!) ?? 0.0
        let doubleMaxDeadLift = Double(maxDeadLiftTF.text!) ?? 0.0
       
        if genderValue == "Male"
        {
           let wilksOutput = calcServ.calculateMensWilksNumberInPounds(maxBench: doubleMaxBench, maxSquat: doubleMaxSquat, maxDeadlift: doubleMaxDeadLift, bodyWeight: doubleBodyWeight)
            wilksScoreTF.text = String(wilksOutput)
        }
        if genderValue == "Female"
        {
            let wilksOutput = calcServ.calculateWomensWilksNumberInPounds(maxBench: doubleMaxBench, maxSquat: doubleMaxSquat, maxDeadlift: doubleMaxDeadLift, bodyWeight: doubleBodyWeight)
            wilksScoreTF.text = String(wilksOutput)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    @IBAction func setGenderValue(_ sender: Any)  {
        
        if(genderSelection.selectedSegmentIndex == 0)
                {
                    genderValue = "Male"
                }
        else if(genderSelection.selectedSegmentIndex == 1)
                {
                    genderValue = "Female"
                }
    }
}


