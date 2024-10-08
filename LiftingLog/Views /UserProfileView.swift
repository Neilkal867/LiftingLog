import SwiftUI

struct UserProfileView: View {
    
    @State private var sex: String = "Male"
    @State private var bodyweight: String = ""
    @State private var maxBench: String = ""
    @State private var maxSquat: String = ""
    @State private var maxDeadlift: String = ""
    @State private var maxOHP: String = ""
    @State private var successfulSubmission = false
    @State private var isLoggedOut = false
    @State private var showAlert: Bool = false
    @State private var showUnsavedDataAlert: Bool = false // Alert for unsaved changes
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @EnvironmentObject var appState: AppState
    
    let sexOptions = ["Male", "Female"]
    let dbService = DatabaseService()
    let authService = AuthenticationService()
    let calcService = CalculationsService()
    var body: some View {
        if  !appState.isLoggedIn {
            LoginView()
        }
        else {
            userProfileForm
        }
    }
    
    var userProfileForm: some View {
        Form {
            Section(header: Text("Personal Information")) {
                Picker("Sex", selection: $sex) {
                    ForEach(sexOptions, id: \.self) {
                        Text($0)
                        //print(userProfile.sex)
                        // print(sex)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onAppear {
                    if GlobalManager.shared.userProfile?.sex != "" {
                        sex = "\((GlobalManager.shared.userProfile?.sex ?? "Male"))"
                    }
                }
                .onChange(of: sex) { newValue in
                    GlobalManager.shared.userProfile?.sex = String(newValue)
                }
                HStack {
                    Text("Bodyweight:")
                    Spacer()
                    TextField("lbs.", text: $bodyweight)
                        .keyboardType(.decimalPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile?.bodyweight != 0 {
                                bodyweight = "\(Int(GlobalManager.shared.userProfile?.bodyweight ?? 0))"
                            }
                        }
                        .onChange(of: bodyweight) { newValue in
                            GlobalManager.shared.userProfile?.bodyweight = Double(newValue) ?? 0
                        }
                }
            }
            
            Section(header: Text("Max Lifts (lbs.)")) {
                HStack {
                    Text("Max Bench Press:")
                    Spacer()
                    TextField("lbs.", text: $maxBench)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile?.maxBench != 0 {
                                maxBench = "\(Int(GlobalManager.shared.userProfile?.maxBench ?? 0))"
                            }
                        }
                        .onChange(of: maxBench) { newValue in
                            GlobalManager.shared.userProfile?.maxBench = Double(newValue) ?? 0
                        }
                }
                
                HStack {
                    Text("Max Squat:")
                    Spacer()
                    TextField("lbs.", text: $maxSquat)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile?.maxSquat != 0 {
                                maxSquat = "\(Int(GlobalManager.shared.userProfile?.maxSquat ?? 0))"
                            }
                        }
                        .onChange(of: maxSquat) { newValue in
                            GlobalManager.shared.userProfile?.maxSquat = Double(newValue) ?? 0
                        }
                }
                
                HStack {
                    Text("Max Deadlift:")
                    Spacer()
                    TextField("lbs.", text: $maxDeadlift)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile?.maxDeadlift != 0 {
                                maxDeadlift = "\(Int(GlobalManager.shared.userProfile?.maxDeadlift ?? 0))"
                            }
                        }
                        .onChange(of: maxDeadlift) { newValue in
                            GlobalManager.shared.userProfile?.maxDeadlift = Double(newValue) ?? 0
                        } 
                }
                
                HStack {
                    Text("Max Overhead Press:")
                    Spacer()
                    TextField("lbs.", text: $maxOHP)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile?.maxOHP != 0 {
                                maxOHP = "\(Int(GlobalManager.shared.userProfile?.maxOHP ?? 0))"
                            }
                        }
                        .onChange(of: maxOHP) { newValue in
                            GlobalManager.shared.userProfile?.maxOHP = Double(newValue) ?? 0
                        }
                }
                Button("Update Profile") {
                    if let bodyweightDouble = Double(bodyweight),
                       let maxBenchDouble = Double(maxBench),
                       let maxSquatDouble = Double(maxSquat),
                       let maxDeadliftDouble = Double(maxDeadlift),
                       let maxOHPDouble = Double(maxOHP) {
                        let newUserEmail = GlobalManager.shared.newUserEmail
                        
                        
                        dbService.updateUserProfile(userID: GlobalManager.shared.userID!, sex: sex, bodyweight: bodyweightDouble, maxBench: maxBenchDouble, maxSquat: maxSquatDouble, maxDeadlift: maxDeadliftDouble, maxOHP: maxOHPDouble) { success, error in
                            if success {
                                print("User profile successfully updated in the private database.")
                            } else if let error = error {
                                print("Error updating user profile in the private database: \(error.localizedDescription)")
                            }
                        }
                        
                        self.successfulSubmission = true
                        alertTitle = "Updated"
                        alertMessage = "Your Profile Has Been Update."
                        showAlert = true
                        
                    } else {
                        // Handle error: one or more of the inputs are not valid numbers
                        print("Error: One or more inputs are invalid.")
                    }
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            
            Section(header: Text("Wilks Number")) {
                HStack {
                    Text("Wilks Score:")
                    Spacer()
                    Text("\(calcService.calculateMensWilksNumberInPounds(), specifier: "%.2f")")
                }
            }
            
            Section(header: Text("Total Lifted Wight")) {
                HStack {
                    Text("Pounds:")
                    Spacer()
                    Text("\(calcService.totalLiftInPounds(), specifier: "%.2f")")
                }
                HStack {
                    Text("Kilograms:")
                    Spacer()
                    Text("\(calcService.totalLiftInKilos(), specifier: "%.2f")")
                }
            }
        }
        .navigationTitle("My Profile")
        .navigationBarItems(trailing: Button("Logout"){
            authService.signOutFromFirebase()
            self.isLoggedOut = true
            appState.logout()
            //appState.isLoggedIn = true
        })
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

