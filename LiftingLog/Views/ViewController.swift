//
//  ViewController.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 9/22/22.
//
// TODO:
// 1) Wire up the Ui to actually save the workout when the user types in the workout values
// 2) Figure out how we want to read the data from the DB and make it usable
import UIKit
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

class ViewController: UIViewController {
    //username textfield
    @IBOutlet var userNameLogin: UITextField!
    //password textfield
    @IBOutlet weak var passwordLogin: UITextField!
    //login button
    @IBOutlet weak var loginButton: UIButton!
    // create account button
    @IBOutlet weak var createAccButton: UIButton!
    
    let auth = AuthenticationService()
    
    override func viewDidLoad()
    {
        title = "Welcome to Lifting Log!"
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func logInClicked(_ sender: UIButton)
    {
        guard let userName = userNameLogin.text, !userName.isEmpty, let password = passwordLogin.text, !password.isEmpty
        else
        {
            self.showAlert(title: "Invalid Username or Password", message: "Please Enter a Valid Username And Password.")
            return
        }
        
        auth.logUserIn(emailAddress: userName, password: password)
        { authresponse in
            if(!authresponse.SuccesfulSignin)
            {
                self.showAlert(title: "Error", message: authresponse.Error)
                return
            }
            DatabaseService().intalizeWorkoutsArray()
            self.navigateToMainDash()
        }
        
        if userNameLogin.text! == "dev" && passwordLogin.text! == "dev"
        {
            //This is a hack to populate the workouts array when logging in for test
            DatabaseService().intalizeWorkoutsArray()
            self.navigateToMainDash()
        }
    }
}
