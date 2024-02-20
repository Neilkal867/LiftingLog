//
//  NewWorkoutView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/19/24.
//

import SwiftUI

struct NewWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var workoutType: String = ""
    @State private var weight: String = ""
    @State private var numOfReps: String = ""
    @State private var numOfSets: String = ""
    @State private var comments: String = ""
    
    @State private var showAlert: Bool = false
    @State private var showUnsavedDataAlert: Bool = false // Alert for unsaved changes
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Workout Type", text: $workoutType)
                TextField("Weight", text: $weight)
                TextField("Number of Reps", text: $numOfReps)
                TextField("Number of Sets", text: $numOfSets)
                // Custom TextEditor with placeholder
                ZStack(alignment: .topLeading) {
                    if comments.isEmpty {
                        Text("Additional Comments")
                            .foregroundColor(.secondary)
                            }
                            TextEditor(text: $comments)
                            .frame(height: 100)
                        }
                               
                Button("Submit Workout") {
                    submitWorkout()
                }
            }
            .navigationBarTitle("Enter a Workout")
            .navigationBarBackButtonHidden(true) // Hide the default back button
            .navigationBarItems(leading: Button(action: {
                // Custom back button action
                if hasUnsavedData() {
                    // Show alert if there's unsaved data
                    showUnsavedDataAlert = true
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Image(systemName: "arrow.left")
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showUnsavedDataAlert) { // Alert for unsaved changes
                Alert(title: Text("Unsaved Changes"),
                      message: Text("You have unsaved changes. Are you sure you want to leave?"),
                      primaryButton: .destructive(Text("Leave")) {
                        presentationMode.wrappedValue.dismiss()
                      },
                      secondaryButton: .cancel()
                )
            }
        }
    }
    
    private func submitWorkout() {
        guard !workoutType.isEmpty, !weight.isEmpty, !numOfReps.isEmpty, !numOfSets.isEmpty else {
            alertTitle = "Required Data"
            alertMessage = "All Fields Must Contain Data. However, Comments Are Optional"
            showAlert = true
            return
        }
       // implement DB Calls here 
        /*let dbService = DatabaseService()
             let todaysDate = dbService.getCurrentMonthDayYear()
             let weightInt = Double(weightTF.text!) ?? 0
             let numOfRepsInt = Double(numOfRepsTF.text!) ?? 0
             let numOfSetsInt = Double(numOfSetsTF.text!) ?? 0
             let comments = commentsTF.text ?? ""
             let newWorkout = dbService.createWorkoutObject(date: todaysDate, workoutType: workoutType, weight: weightInt, reps: numOfRepsInt, sets: numOfSetsInt, comments: comments)
             
             dbService.saveWorkout(workout: newWorkout)*/
        
        alertTitle = "Submitted"
        alertMessage = "Workout Successfully Submitted"
        showAlert = true
        clearTextFields()
    }
    
    private func clearTextFields() {
        workoutType = ""
        weight = ""
        numOfReps = ""
        numOfSets = ""
        comments = ""
    }
    
    // Function to check if any TextField has unsaved data
    private func hasUnsavedData() -> Bool {
        return !workoutType.isEmpty || !weight.isEmpty || !numOfReps.isEmpty || !numOfSets.isEmpty || !comments.isEmpty
    }
}

struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView()
    }
}
