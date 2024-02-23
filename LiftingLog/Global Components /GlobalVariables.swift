//
//  GlobalVariables.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/23/24.
//

import SwiftUI

class GlobalManager {
    static let shared = GlobalManager()
    
    var newUserEmail: String = ""
    
    private init() {} // Private initialization to ensure only one instance is created.
}



// Set the variable in one file
//GlobalManager.shared.someVariable = "Hello"

// Access it in another file
//print(GlobalManager.shared.someVariable)
