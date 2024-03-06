//
//  SubmittedWorkoutsView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/20/24.
//
import SwiftUI
import CloudKit

struct SubmittedWorkoutsView: View {
    @State private var errorMessage: String?

    var body: some View {
        List(GlobalManager.shared.workoutArray ?? [], id: \.id) { workout in
            VStack(alignment: .leading) {
                Text(workout.date)
                    .font(.headline)
                Text(workout.workoutType)
                    .font(.subheadline)
                HStack {
                    Text("Weight: \(workout.weight, specifier: "%.1f") lbs.")
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
        .navigationTitle("Submitted Workouts")
        .alert(isPresented: .constant(errorMessage != nil), content: {
            Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        })
    }
}

#Preview {
    SubmittedWorkoutsView()
}
