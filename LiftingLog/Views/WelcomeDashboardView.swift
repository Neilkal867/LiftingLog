//
//  WelcomeDashboardView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/19/24.
//

import SwiftUI

// Define a struct that conforms to View for our SwiftUI representation of the Welcome Dashboard
struct WelcomeDashboardView: View {
    // Define the list of options available in the dashboard
    let welcomeDashOptions = ["My Profile", "New Workout", "View Past Workout", "Wilks Calculator", "1RM Calculator", "Lifting Buddy"]
    
    // The body property defines the view's content
    var body: some View {
        // Use NavigationView to enable navigation between views
        NavigationView {
            // Use List to create a list of items
            List(welcomeDashOptions.indices, id: \.self) { index in
                // Use NavigationLink to create a tappable list item that navigates to a new view
                NavigationLink(destination: destinationView(for: index)) {
                    Text(welcomeDashOptions[index])
                }
            }
            .navigationTitle("Pump Path!") // Set the title of the navigation bar
            .navigationBarBackButtonHidden(true) // Hide the back button
        }
    }
    
    // Function to return the appropriate destination view based on the selected option
    private func destinationView(for index: Int) -> some View {
        switch welcomeDashOptions[index] {
        case "My Profile":
            return AnyView(UserProfileView())
        case "New Workout":
            return AnyView(NewWorkoutView())
       // case "View Past Workout":
            // Assuming PastWorkoutsView is the SwiftUI view for past workouts
            //return AnyView(PastWorkoutsView())
        case "Wilks Calculator":
            return AnyView(WilksCalculatorView())
        case "1RM Calculator":
            return AnyView(OneRMCalculatorView())
        case "Lifting Buddy":
            return AnyView(LiftingBuddyView())
        default:
            return AnyView(Text("Selection not found"))
        }
    }
}

// Define a struct for each destination view, assuming they are not yet implemented. For example:


// Repeat the above struct definition for NewWorkoutView, WilksCalculatorView, OneRMCalculatorView, and LiftingBuddyView.


#Preview {
    WelcomeDashboardView()
}
