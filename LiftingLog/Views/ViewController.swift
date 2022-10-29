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
    var auth = AuthenticationService();
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
        guard let userName = userNameLogin.text, !userName.isEmpty, let password = passwordLogin.text, !password.isEmpty else{
            let alert = UIAlertController(title: "Invalid Username or Password", message:"Please Enter in a Valid Username & Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default Action"), style: .default, handler:{ _ in NSLog("The \"OK\" alert occured")}))
            self.present(alert, animated: true, completion: nil)
            print( "Cannot Leave Username or Password Blank")
            return
     }
        auth.logUserIn(emailAddress: userNameLogin.text!, password: passwordLogin.text!)
            //if loginStateStruct == true
    //    {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc: UITableViewController = mainStoryboard.instantiateViewController(withIdentifier: "welcomeDash") as! UITableViewController
            navigationController?.pushViewController(vc, animated: true)
        //}
       
        
    }
    
    
    
    
}
    //func getWilksNumber(){
     
      //  calcService.
    //}

