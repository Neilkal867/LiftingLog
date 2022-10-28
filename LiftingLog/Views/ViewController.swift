//
//  ViewController.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 9/22/22.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore



class ViewController: UIViewController {
    
   // var calcService = CalculationsService();
    //username textfield
    @IBOutlet var userNameLogin: UITextField!
    //password textfield
    @IBOutlet weak var passwordLogin: UITextField!
    //login button
    @IBOutlet weak var loginButton: UIButton!
    // create account button 
    @IBOutlet weak var createAccButton: UIButton!
    
    override func viewDidLoad() {
        title = "Welcome to Lifting Log!"
        navigationItem.setHidesBackButton(true, animated: true)
        
  
    }

    @IBAction func logInClicked(_ sender: UIButton) {
        guard let userName = userNameLogin.text, !userName.isEmpty, let passWord = passwordLogin.text, !passWord.isEmpty else
        {
            print("Cannot Leave Username or Password Blank")
            return
        }
        print(self.userNameLogin.text!)
        print(self.passwordLogin.text!)
    }
   
    //func getWilksNumber(){
     
      //  calcService.
    //}
}

