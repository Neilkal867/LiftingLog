//
//  NewWorkoutView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/19/24.
//

import SwiftUI

struct OneRMCalculatorView: View {
    // State variables to hold the user inputs and calculation results
    @State private var bodyWeight = "" // Holds the input for body weight
    @State private var numberOfReps = "" // Holds the input for the number of reps
    @State private var oneRMOutput = "" // Holds the calculated 1RM output
    @State private var showAlert = false // Controls the visibility of the alert
    @State private var alertMessage = "" // Holds the message to be displayed in the alert

    var calcServ = CalculationsService() // Instance of the calculations service
   
    var body: some View {
            Form {
                Section(header: Text("Input your personal data (lbs.)")) {
                    // TextField for body weight with decimal pad for numerical input
                    TextField("Body Weight", text: $bodyWeight)
                        .keyboardType(.decimalPad) // Shows a keyboard suitable for numerical input including decimals
                    // TextField for number of reps with number pad for integer input
                    TextField("Number of Reps", text: $numberOfReps)
                        .keyboardType(.numberPad) // Shows a keyboard suitable for integer numerical input
    
                    // Button to trigger the 1RM calculation
                    Button("Calculate 1RM") {
                        calculateRM()
                    }
                }
                
                Section {
                    // Displays the calculated 1RM
                    Text(oneRMOutput.isEmpty ? "Enter values to calculate 1RM score" : oneRMOutput)
                }
            }
            .navigationBarTitle("1RM Calculator")
            // Alert for invalid input or calculation errors
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    
    // Function to calculate the 1RM using the inputs
    private func calculateRM() {
        guard !bodyWeight.isEmpty, let doubleBodyWeight = Double(bodyWeight), // Validates body weight input
              !numberOfReps.isEmpty, let intNumberOfReps = Int(numberOfReps), intNumberOfReps >= 1 // Validates number of reps input
        else {
            // Sets the alert message for invalid input and shows the alert
            self.alertMessage = "Bodyweight & Number of Reps must be valid and Number of Reps cannot be less than 1."
            self.showAlert = true
            return
        }
        
        // Calls the calculation service to compute the 1RM
        let rmCalc = calcServ.calculateOneRepMax(weight: doubleBodyWeight, reps: Double(intNumberOfReps))
        oneRMOutput = "1RM: \(rmCalc)" // Updates the UI with the calculated 1RM
    }
    
}

// Preview provider for SwiftUI previews
struct OneRMCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        OneRMCalculatorView()
    }
}
