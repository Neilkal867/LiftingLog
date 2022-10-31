//
//  WilksCalculatorController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/28/22.
//

import UIKit

class WilksCalculatorController: UIViewController {

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
        setGenderValue()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setGenderValue(){
        let maleGender = {(action: UIAction) in
            // set male selected here
            print("Male Selected")
        }
        
        let femaleGender = {(action: UIAction) in
            // set female selected here
            print("Female Selected")
        }
        
        
        genderSelector.menu = UIMenu(children: [
            UIAction(title: "Male", state: .on, handler: maleGender),
            UIAction(title: "Female", state: .on, handler: femaleGender)])
        
        genderSelector.showsMenuAsPrimaryAction = true
        genderSelector.changesSelectionAsPrimaryAction = true 
    }
}
