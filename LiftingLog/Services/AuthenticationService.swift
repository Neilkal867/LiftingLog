//
//  AuthenticationService.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 10/27/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import UIKit


class AuthenticationService
{
    init(){}
    
    func createUser(emailAddress: String, password: String)
    {
        
        Auth.auth().createUser(withEmail: emailAddress, password: password) {result, error in
            if error != nil {
                //show an error to the user
                print(error.unsafelyUnwrapped)
            
            }
            
            if result != nil {
                //Might have to advance screens here
                print("success")
                
            }
        }
    
    }
    
    func logUserIn(emailAddress: String, password: String)
    {
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) {result, error in
            if error != nil {
                //Show an error to the user
                print(error.unsafelyUnwrapped)
                
            }
            
            if result != nil {
                //Might have to advance screens here
                print("success")
            }
        }
    }
}
