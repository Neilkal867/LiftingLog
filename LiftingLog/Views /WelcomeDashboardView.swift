//
//  WelcomeDashboardView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/19/24.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var recipients: [String]
    var subject: String
    var messageBody: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = context.coordinator
        mailComposerVC.setToRecipients(recipients)
        mailComposerVC.setSubject(subject)
        mailComposerVC.setMessageBody(messageBody, isHTML: false)
        return mailComposerVC
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView

        init(_ mailView: MailView) {
            self.parent = mailView
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
// Define a struct that conforms to View for our SwiftUI representation of the Welcome Dashboard
struct WelcomeDashboardView: View {
    // Define the list of options available in the dashboard
    let welcomeDashOptions = ["My Profile", 
                              "New Workout",
                              "View Past Workout",
                              "531 Workout Plan",
                              //"Wilks Calculator",
                              "1RM Calculator",
                              "Lifting Buddy"]
    @State private var showingMailView = false
    // The body property defines the view's content
    var body: some View {
        // Use NavigationView to enable navigation between views
        NavigationView {
            VStack{
                List(welcomeDashOptions.indices, id: \.self) { index in
                    // Use NavigationLink to create a tappable list item that navigates to a new view
                    NavigationLink(destination: destinationView(for: index)) {
                        Text(welcomeDashOptions[index])
                    }
                }
                Spacer()
                
                Button("Send Feedback") {
                    self.showingMailView = true
                }
                .sheet(isPresented: $showingMailView) {
                    if MFMailComposeViewController.canSendMail() {
                        MailView(recipients: ["joemelito1193@gmail.com","neilkal867@yahoo.com"], subject: "Pump Path App Feedback", messageBody: "Here is my feedback regarding your app, Pump Path:")
                    } else {
                        // Fallback if mail services are not available
                        Text("Cannot send emails from this device")
                    }
                }
                .navigationTitle("Pump Path!") // Set the title of the navigation bar
                .navigationBarBackButtonHidden(true) // Hide the back button
            }
        }
    }
    
    // Function to return the appropriate destination view based on the selected option
    private func destinationView(for index: Int) -> some View {
        switch welcomeDashOptions[index] {
        case "My Profile":
            return AnyView(UserProfileView())
        case "New Workout":
            return AnyView(NewWorkoutView())
       case "View Past Workout":
            return AnyView(SubmittedWorkoutsView())
       // case "Wilks Calculator":
            //return AnyView(WilksCalculatorView())
        case "531 Workout Plan":
            return AnyView(Workout531View())
        case "1RM Calculator":
            return AnyView(OneRMCalculatorView())
        case "Lifting Buddy":
            return AnyView(LiftingBuddyView())
        default:
            return AnyView(Text("Selection not found"))
        }
    }
}
#Preview {
    WelcomeDashboardView()
}
