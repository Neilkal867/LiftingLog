//
//  NewWorkoutView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/19/24.
//

import SwiftUI

// ViewModel to handle calculations and store the inputs and outputs
class WilksCalculatorViewModel: ObservableObject {
    @Published var bodyWeight: String = ""
    @Published var maxBench: String = ""
    @Published var maxSquat: String = ""
    @Published var maxDeadlift: String = ""
    @Published var wilksScore: String = ""
    @Published var gender: String = "Male"
    var calcServ = CalculationsService() // Assuming CalculationsService exists and is adapted for SwiftUI usage
    func calculateWilksScore() {
        guard let doubleBodyWeight = Double(bodyWeight), let doubleMaxBench = Double(maxBench),
              let doubleMaxSquat = Double(maxSquat), let doubleMaxDeadlift = Double(maxDeadlift) else {
            // Handle error - in SwiftUI, you might use an alert
            return
        }
        
        // Calculations based on gender
        if gender == "Male" {
            let wilksOutput = calcServ.calculateMensWilksNumberInPounds(maxBench: doubleMaxBench, maxSquat: doubleMaxSquat, maxDeadlift: doubleMaxDeadlift, bodyWeight: doubleBodyWeight)
            wilksScore = String(wilksOutput)
        } else if gender == "Female" {
            let wilksOutput = calcServ.calculateWomensWilksNumberInPounds(maxBench: doubleMaxBench, maxSquat: doubleMaxSquat, maxDeadlift: doubleMaxDeadlift, bodyWeight: doubleBodyWeight)
            wilksScore = String(wilksOutput)
        }
    }
}

import SwiftUI

struct WilksCalculatorView: View {
    @StateObject private var viewModel = WilksCalculatorViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Input your personal data (lbs.)")) {
                TextField("Body Weight", text: ($viewModel.bodyWeight))
                    .keyboardType(.decimalPad)
                
                TextField("Max Bench", text: ($viewModel.maxBench))
                    .keyboardType(.numberPad)
                
                TextField("Max Squat", text: ($viewModel.maxSquat))
                    .keyboardType(.numberPad)
                
                TextField("Max Deadlift", text: ($viewModel.maxDeadlift))
                    .keyboardType(.numberPad)
                
                Picker("Gender", selection: $viewModel.gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                Button("Calculate Wilks Score") {
                    viewModel.calculateWilksScore()
                }
            }
            
            Section(header: Text("Result")) {
                Text(viewModel.wilksScore.isEmpty ? "Enter values to calculate the Wilks score" : viewModel.wilksScore)
            }
        }
        .navigationTitle("Wilks Calculator")
    }
}

// Preview provider for SwiftUI previews in Xcode
struct WilksCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        WilksCalculatorView()
    }
}
