//
//  CreateAccountView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 3/6/24.
//

import SwiftUI

struct CreateAccountView: View {
    // State variables to hold the input text values
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var dateOfBirth = Date()
    
    @State private var isAuthenticated = false
    @State private var isCancel = false
    @State private var showAlert = false
    @State private var showFillOutAlert = false
    @State private var isDatePickerPresented = false
    
    var body: some View {
        if isAuthenticated {
            WelcomeDashboardView()
        } else if isCancel {
            LoginView()
        } else {
            createAccForm
        }
    }
    
    var createAccForm: some View {
        NavigationView {
            Form {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $userName)
                SecureField("Password", text: $password)
                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                
                Button("Create Account") {
                    createAccountClicked()
                }
                .alert(isPresented: $showFillOutAlert) { // New alert for missing information
                    Alert(
                        title: Text("Missing Information"),
                        message: Text("Please fill out all fields to create an account."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .navigationBarTitle("Account Creation")
            .navigationBarItems(leading: Button("Cancel") {
                self.showAlert = true
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text("Are you sure you want to cancel?"),
                    primaryButton: .destructive(Text("Yes")) {
                        self.isCancel = true
                        print("Cancelled.")
                        // Logic to handle cancellation here
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    func createAccountClicked() {
        // Implement account creation logic here
        print(firstName, lastName, userName, password, dateOfBirth)
        if !userName.isEmpty && !password.isEmpty {
            self.isAuthenticated = true
            // User account creation logic here
        }
        else {
            self.showFillOutAlert = true
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
