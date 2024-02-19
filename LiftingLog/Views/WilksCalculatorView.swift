
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
        NavigationView {
            Form {
                Section(header: Text("Input your data")) {
                    TextField("Body Weight", text: numericalBinding($viewModel.bodyWeight))
                        .keyboardType(.decimalPad)
                    TextField("Max Bench", text: numericalBinding($viewModel.maxBench))
                        .keyboardType(.decimalPad)
                    TextField("Max Squat", text: numericalBinding($viewModel.maxSquat))
                        .keyboardType(.decimalPad)
                    TextField("Max Deadlift", text: numericalBinding($viewModel.maxDeadlift))
                        .keyboardType(.decimalPad)

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
    
    // Custom binding to filter out non-numerical input
    private func numericalBinding(_ binding: Binding<String>) -> Binding<String> {
        Binding<String>(
            get: {
                binding.wrappedValue
            },
            set: {
                binding.wrappedValue = $0.filter { "0123456789.".contains($0) }
            }
        )
    }
}

// Preview provider for SwiftUI previews in Xcode
struct WilksCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        WilksCalculatorView()
    }
}
