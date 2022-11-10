//
//  CreateAccountController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 9/27/22.
//

import UIKit
import FirebaseAuth

class CreateAccountController: UIViewController {
    //first name textfield
    @IBOutlet weak var firstNameCA: UITextField!
    //last name text field
    @IBOutlet weak var lastNameCA: UITextField!
    // username or email text field
    @IBOutlet weak var userNameCA: UITextField!
    // password textfield
    @IBOutlet weak var passwordCA: UITextField!
    //datepicker or date of birth textfield (this later gets converted to a date picker in the code)
    @IBOutlet weak var datePickerTF: UITextField!
    
    let auth = AuthenticationService()
    
    override func viewDidLoad()
    {
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
    
    @objc func dateChange(dateOfBirth: UIDatePicker)
    {
        datePickerTF.text = formatDate(date: dateOfBirth.date)
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func createAccountClicked(_ sender: UIButton)
    {
        print(self.firstNameCA.text!)
        print(self.lastNameCA.text!)
        print(self.userNameCA.text!)
        print(self.passwordCA.text!)
        print(self.datePickerTF.text!)
        
        if  self.userNameCA.text != nil && self.passwordCA.text != nil
        {
            let userName = self.userNameCA.text!
            let password = self.passwordCA.text!
            
            createUser(emailAddress: userName, password: password)
        }
    }
    
    func createUser(emailAddress: String, password: String)
    {
        Auth.auth().createUser(withEmail: emailAddress, password: password) {result, error in
            if error != nil
            {
                self.showAlert(title: "Error creating account", message: error!.localizedDescription)
            }
            
            if result != nil
            {
                self.mainDashUIVC(vcToDisplay: "LoginView", viewController: ViewController.self)
                self.showAlert(title: "Account Created", message: "You have successfully created an account")
            }
        }
    }
}
