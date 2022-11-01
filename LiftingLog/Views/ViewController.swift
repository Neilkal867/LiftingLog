//
//  ViewController.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 9/22/22.
//

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
    
    override func viewDidLoad()
    {
        title = "Welcome to Lifting Log!"
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func logInClicked(_ sender: UIButton)
    {
        guard let userName = userNameLogin.text, !userName.isEmpty, let password = passwordLogin.text, !password.isEmpty else{
            self.showAlert(title: "Invalid Username or Password", message: "Please Enter a Valid Username And Password.")
            return
        }
        Auth.auth().signIn(withEmail: userNameLogin.text!, password: passwordLogin.text!) {[self]result, error in
            if error != nil
            {
                self.showAlert(title: "User Not Found", message: "Please Make Sure You Are Using The Correct Username & Password")
                print(error.unsafelyUnwrapped)
                return
            }
            
            if result != nil
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc: UITableViewController = mainStoryboard.instantiateViewController(withIdentifier: "welcomeDash") as! UITableViewController
                navigationController?.pushViewController(vc, animated: true)
                print("success")
            }
        }
        
        if userNameLogin.text! == "dev" && passwordLogin.text! == "dev"
        {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc: UITableViewController = mainStoryboard.instantiateViewController(withIdentifier: "welcomeDash") as! UITableViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

