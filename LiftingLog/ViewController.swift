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
}

