//
//  ResetPasswordView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 3/6/24.
//

import SwiftUI
//import FirebaseAuth

// ViewModel to handle the logic for resetting password
class ResetPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    func sendResetPasswordEmail() {
        // Simulating sending a reset password email
        // You should replace this with your actual authentication service code
        // For example, using FirebaseAuth:
        // Auth.auth().sendPasswordReset(withEmail: email) { error in
        //     DispatchQueue.main.async {
        //         if let error = error {
        //             self.alertMessage = error.localizedDescription
        //             self.showAlert = true
        //         } else {
        //             self.alertMessage = "Reset email has been sent"
        //             self.showAlert = true
        //         }
        //     }
        // }
    }
}

// SwiftUI view for resetting password
struct ResetPasswordView: View {
    @StateObject private var viewModel = ResetPasswordViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Send Reset Email") {
                    viewModel.sendResetPasswordEmail()
                }
                .padding()
            }
            .navigationTitle("Reset Password")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Reset Password"),
                      message: Text(viewModel.alertMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

// Entry point for the SwiftUI app or a specific view, depending on your app structure
struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
