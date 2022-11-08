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
    @IBOutlet weak var genderSelector: UIButton!
    @IBOutlet weak var bodyWeightTF: UITextField!
    @IBOutlet weak var maxBenchTF: UITextField!
    @IBOutlet weak var maxSquatTF: UITextField!
    @IBOutlet weak var maxDeadLiftTF: UITextField!
    @IBOutlet weak var calcWilksButton: UIButton!
    @IBOutlet weak var wilksScoreTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Wilks Calculator"
      
        self.hideKeyboardWhenTappedAround()
    }
    
    
    
    @IBAction func calculateWilksButton(_ sender: UIButton) {
        guard let bodyWeight = bodyWeightTF.text, !bodyWeight.isEmpty, let maxBench = maxBenchTF.text, !maxBench.isEmpty,
              let maxSquat = maxSquatTF.text, !maxSquat.isEmpty, let maxDeadLift = maxDeadLiftTF.text, !maxDeadLift.isEmpty
        else{
            showAlert(title: "Blank Values", message: "Bodyweight, Max Bench, Max Squat, & Max Deadlift Cannot Be Left Blank")
            return
        }
        
        var genderValue = setGenderValue()
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
    
    func setGenderValue() -> String{
        let maleGender = {(action: UIAction) in
            self.genderValue = "Male"
            print("Male Selected")
        }
        
        let femaleGender = {(action: UIAction) in
            self.genderValue = "Female"
            print("Female Selected")
        }
        
        let selectGender = {(action: UIAction) in
            self.genderValue = ""
            print("No Gender Selected")
        }
        
        genderSelector.menu = UIMenu(children: [
            UIAction(title: "Tap To Select Gender", state: .off, handler: selectGender),
            UIAction(title: "Male", state: .on, handler: maleGender),
            UIAction(title: "Female", state: .on, handler: femaleGender)])
        
        genderSelector.showsMenuAsPrimaryAction = true
        genderSelector.changesSelectionAsPrimaryAction = true
        return genderValue
    }
}
