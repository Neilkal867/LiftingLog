//
//  NewWorkoutView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/19/24.
//

import SwiftUI

struct UserProfileView: View {
    @State private var userProfile = UserProfile(email: "",userID: "", sex: "Male", bodyweight: 0, maxBench: 0, maxSquat: 0, maxDeadlift: 0, maxOHP: 0)
    @State private var bodyweightText: String = ""
    @State private var maxBenchText: String = ""
    @State private var maxSquatText: String = ""
    @State private var maxDeadliftText: String = ""
    @State private var maxOHPText: String = ""
    let sexes = ["Male", "Female"]
    
    var body: some View {
            Form {
                Section(header: Text("Personal Information")) {
                    Picker("Sex", selection: $userProfile.sex) {
                        ForEach(sexes, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Bodyweight (lbs.)", text: $bodyweightText)
                        .keyboardType(.decimalPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.bodyweight != 0 {
                                bodyweightText = "\(GlobalManager.shared.userProfile!.bodyweight)"
                            }
                        }
                        .onChange(of: bodyweightText) { newValue in
                            userProfile.bodyweight = Double(newValue) ?? 0
                        }
                }
                
                Section(header: Text("Max Lifts (lbs.)")) {
                    TextField("Max Bench Press", text: $maxBenchText)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.maxBench != 0 {
                                maxBenchText = "\(GlobalManager.shared.userProfile!.maxBench)"
                            }
                        }
                        .onChange(of: maxBenchText) { newValue in
                            userProfile.maxBench = Double(newValue) ?? 0
                        }
                    
                    TextField("Max Squat", text: $maxSquatText)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.maxSquat != 0 {
                                maxSquatText = "\(GlobalManager.shared.userProfile!.maxSquat)"
                            }
                        }
                        .onChange(of: maxSquatText) { newValue in
                            userProfile.maxSquat = Double(newValue) ?? 0
                        }
                    
                    TextField("Max Deadlift", text: $maxDeadliftText)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.maxDeadlift != 0 {
                                maxDeadliftText = "\(GlobalManager.shared.userProfile!.maxDeadlift)"
                            }
                        }
                        .onChange(of: maxDeadliftText) { newValue in
                            userProfile.maxDeadlift = Double(newValue) ?? 0
                        }
                    
                    TextField("Max Overhead Press", text: $maxOHPText)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.maxOHP != 0 {
                                maxOHPText = "\(GlobalManager.shared.userProfile!.maxOHP)"
                            }
                        }
                        .onChange(of: maxOHPText) { newValue in
                            userProfile.maxOHP = Double(newValue) ?? 0
                        }
                
                }
            }
            .navigationTitle("My Profile")
        
        }
    }

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
