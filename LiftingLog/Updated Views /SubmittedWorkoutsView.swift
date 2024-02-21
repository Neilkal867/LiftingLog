//
//  SubmittedWorkoutsView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/20/24.
//

import SwiftUI

import SwiftUI
import CloudKit

struct SubmittedWorkoutsView: View {
    @State private var workoutsArray: [Workout] = []
    @State private var errorMessage: String?
    var dbServ = DatabaseService()
    // Assuming `privateDB` is accessible here, you might need to define it if it's not globally available.
    let privateDB = CKContainer.default().privateCloudDatabase

    var body: some View {
            List(workoutsArray, id: \.id) { workout in
                VStack(alignment: .leading) {
                    Text(workout.date)
                        .font(.headline)
                    Text(workout.workoutType)
                        .font(.subheadline)
                    HStack {
                        Text("Weight: \(workout.weight, specifier: "%.1f") kg")
                        Spacer()
                        Text("Reps: \(Int(workout.reps))")
                        Spacer()
                        Text("Sets: \(Int(workout.sets))")
                    }
                    if !workout.comments.isEmpty {
                        Text("Comments: \(workout.comments)")
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Workouts")
            .onAppear {
                dbServ.loadWorkouts { [self] (workouts, error) in
                    DispatchQueue.main.async {
                        if let workouts = workouts {
                            self.workoutsArray = workouts
                        } else if let error = error {
                            self.errorMessage = error.localizedDescription
                            // Handle the error, e.g., show an alert
                        }
                    }
                }
            }
        }
    }


#Preview {
    SubmittedWorkoutsView()
}
