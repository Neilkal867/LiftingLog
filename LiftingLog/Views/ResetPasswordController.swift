//
//  ResetPasswordController.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 11/30/22.
//
import UIKit
import FirebaseAuth

class ResetPasswordController: UIViewController {

    @IBOutlet var emailBox: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Reset Password"
    }
        
    @IBAction func sendResetPasswordEmail(_ sender: Any)
    {
        let auth = AuthenticationService()
        
        auth.sendResetPasswordEmail(emailAddress: emailBox.text!) { Authresponse in
            if(Authresponse.SuccesfulSignin)
            {
                self.mainDashUIVC(vcToDisplay: "LoginView", viewController: ViewController.self)
                self.showAlert(title: "Sucess", message: "Reset email has been set")
            }
            else
            {
                self.showAlert(title: "Error", message: Authresponse.Error)
            }
        }
    }
}
