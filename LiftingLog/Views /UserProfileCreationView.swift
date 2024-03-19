//
//  UserProfileCreationView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/23/24.
//

import SwiftUI

struct UserProfileCreationView: View {
    @State private var sex: String = "Male"
    @State private var bodyweight: String = ""
    @State private var maxBench: String = ""
    @State private var maxSquat: String = ""
    @State private var maxDeadlift: String = ""
    @State private var maxOHP: String = ""
    @State private var successfulSubmission = false
    
    let sexOptions = ["Male", "Female"]
    let dbService = DatabaseService()
    let authService = AuthenticationService()
    
    var body: some View {
        if successfulSubmission {
            LoginView()
        }
        else {
            newUserForm
        }
    }
    
    var newUserForm: some View {
        Form {
            Section(header: Text("General Information")) {
                Picker("Gender", selection: $sex) {
                    ForEach(sexOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Body Weight (lbs)", text: $bodyweight)
                    .keyboardType(.decimalPad) // Use .decimalPad for numeric input that can include decimal points
            }
            
            Section(header: Text("Max Lifts")) {
                TextField("Max Bench Press (lbs)", text: $maxBench)
                    .keyboardType(.decimalPad)
                TextField("Max Squat (lbs)", text: $maxSquat)
                    .keyboardType(.decimalPad)
                TextField("Max Deadlift (lbs)", text: $maxDeadlift)
                    .keyboardType(.decimalPad)
                TextField("Max Overhead Press (lbs)", text: $maxOHP)
                    .keyboardType(.decimalPad)
            }
            
            
            Button("Submit") {
                //this button also needs to take the use to the welcome screen 
                if let bodyweightDouble = Double(bodyweight),
                   let maxBenchDouble = Double(maxBench),
                   let maxSquatDouble = Double(maxSquat),
                   let maxDeadliftDouble = Double(maxDeadlift),
                   let maxOHPDouble = Double(maxOHP) {
                    
                    let newUserEmail = GlobalManager.shared.newUserEmail
                    
                    var userprofile = dbService.createUserProfile(email: GlobalManager.shared.newUserEmail!, sex: sex , bodyweight: bodyweightDouble, maxBench: maxBenchDouble, maxSquat: maxSquatDouble, maxDeadlift: maxDeadliftDouble, maxOHP: maxOHPDouble)
                    
                    dbService.createNewUser(profile: userprofile)
                    
                    GlobalManager.shared.userProfile?.bodyweight = bodyweightDouble
                    GlobalManager.shared.userProfile?.maxSquat = maxBenchDouble
                    GlobalManager.shared.userProfile?.maxBench = maxSquatDouble
                    GlobalManager.shared.userProfile?.maxDeadlift = maxDeadliftDouble
                    GlobalManager.shared.userProfile?.maxOHP = maxOHPDouble
                    
                    authService.signOutFromFirebase()
                    self.successfulSubmission = true
                    
                } else {
                    // Handle error: one or more of the inputs are not valid numbers
                    print("Error: One or more inputs are invalid.")
                }
            }
        }.navigationTitle("New User Profile Setup")
    }
    
}
#Preview {
    UserProfileCreationView()
}
