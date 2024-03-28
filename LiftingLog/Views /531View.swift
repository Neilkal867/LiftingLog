//
//  531View.swift
//  LiftingLog
//
//  Created by Joseph Melito on 3/22/24.
//

import SwiftUI

struct Workout531View: View {
    // Replace these dictionaries with your actual data source for warm-up and weekly exercises
    let warmUpData: [String: Int] = ["Press": 50, "Deadlift": 80, "Bench": 70, "Squat": 90]
    let weeklyData: [[String: Int]] = [
        ["Press": 55, "Deadlift": 85, "Bench": 75, "Squat": 95],
        ["Press": 60, "Deadlift": 90, "Bench": 80, "Squat": 100],
        ["Press": 65, "Deadlift": 95, "Bench": 85, "Squat": 105],
        ["Press": 70, "Deadlift": 100, "Bench": 90, "Squat": 110]
    ]
    
    // State variable to keep track of the selected week.
    // It starts with '0' to indicate that 'Week 1' is selected by default.
    @State private var selectedWeek = 0
    
    // Array holding the titles for the weeks to be used in the Picker
    let weeks = ["Week 1", "Week 2", "Week 3", "Week 4"]

    var body: some View {
        VStack {
            // A list that will act as a container for our warm-up and weekly exercise tables
            List {
                // The warm-up section is always displayed
                Section(header: Text("Warm Ups")) {
                    ForEach(warmUpData.sorted(by: >), id: \.key) { exercise, weight in
                        HStack {
                            Text(exercise)
                            Spacer()
                            // Displaying the weight for each warm-up exercise
                            Text("\(weight)")
                                .frame(width: 50, alignment: .trailing)
                        }
                    }
                }
                
                // This section will display the exercises for the selected week
                Section(header: Text(weeks[selectedWeek])) {
                    ForEach(weeklyData[selectedWeek].sorted(by: >), id: \.key) { exercise, weight in
                        HStack {
                            Text(exercise)
                            Spacer()
                            // Displaying the weight for each exercise for the selected week
                            Text("\(weight)")
                                .frame(width: 50, alignment: .trailing)
                        }
                    }
                }
            }
            ///
            // Picker used as a segmented control to select the week
            Picker("Select Week", selection: $selectedWeek) {
                // Options for each week
                ForEach(0..<weeks.count, id: \.self) { index in
                    Text(self.weeks[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // Makes the picker look like a segmented control
            .padding() // Adds padding around the picker for better aesthetics
        }
        .navigationBarTitle("531 Workout Plan") // Sets the title for the navigation bar
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview provider to render the view in the canvas or a live preview
        Workout531View()
    }
}
