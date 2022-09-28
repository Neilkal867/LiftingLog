//
//  CreateAccountController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 9/27/22.
//

import UIKit

class CreateAccountController: UIViewController {

    @IBOutlet weak var datePickerTF: UITextField!
    //@IBOutlet var datePicker: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Account Creation"
        navigationItem.setHidesBackButton(true, animated: true)
        
        let dateOfBirth = UIDatePicker()
        dateOfBirth.datePickerMode = .date
        dateOfBirth.addTarget(self, action: #selector(dateChange(dateOfBirth:)), for: UIControl.Event.valueChanged)
        dateOfBirth.frame.size   = CGSize(width: 0, height: 300)
        dateOfBirth.preferredDatePickerStyle = .wheels
        dateOfBirth.maximumDate = Date()
       
        datePickerTF.inputView = dateOfBirth
        datePickerTF.text = "Date of Birth"
    }
    
    @objc func dateChange(dateOfBirth: UIDatePicker){
        
        datePickerTF.text = formatDate(date: dateOfBirth.date)
    }
    
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: date)
    }
}
