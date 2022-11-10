//
//  AuthenticationService.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 10/27/22.
//

import Foundation
import FirebaseAuth

class AuthenticationService
{
    init(){}
    
    func createUser(emailAddress: String, password: String)
    {
        
        Auth.auth().createUser(withEmail: emailAddress, password: password) {result, error in
            if error != nil
            {
                //show an error to the user
                print(error.unsafelyUnwrapped)
            }
            
            if result != nil {
                //Might have to advance screens here
                print("success")
                
            }
        }
    }
    
    func logUserIn(emailAddress: String, password: String, completion: @escaping(Bool) -> ())
    {
        let db = DatabaseService()
        
        Auth.auth().signIn(withEmail: emailAddress, password: password)
        {result, error in
            if error != nil
            {
                print(error.unsafelyUnwrapped)
                completion(false)
            }
            
            if result != nil
            {
                //If the user logs in successfully populate the workouts array
                db.intalizeWorkoutsArray()
                completion(true)
            }
        }
    }
}


