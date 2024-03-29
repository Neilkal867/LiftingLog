import SwiftUI

// Define a data structure to hold the weights for each exercise and its subtypes
struct ExerciseData {
    var data: [String: [String: [Int]]]
    
    func weights(for exercise: String, subtype: String) -> [Int] {
        return data[exercise]?[subtype] ?? []
    }
}

struct Workout531View: View {
    @State private var selectedExercise = "Warmup"
    let exercises = ["Warmup", "Squat", "Bench", "Deadlift", "Press"]
    
    // Initialize with an empty data structure
    @State private var exerciseData = ExerciseData(data: [:])

    // Function to populate the exercise data
    func populateExerciseData() {
        let c = CalculationsService()
        let u = GlobalManager.shared.userProfile!
        
        let ws1 = c.warmUpOne(workoutWeight: u.maxSquat)
        let ws2 = c.warmUpTwo(workoutWeight: u.maxSquat)
        let ws3 = c.warmUpThree(workoutWeight: u.maxSquat)
        
        let wb1 = c.warmUpOne(workoutWeight: u.maxBench)
        let wb2 = c.warmUpTwo(workoutWeight: u.maxBench)
        let wb3 = c.warmUpThree(workoutWeight: u.maxBench)
        
        let wd1 = c.warmUpOne(workoutWeight: u.maxDeadlift)
        let wd2 = c.warmUpTwo(workoutWeight: u.maxDeadlift)
        let wd3 = c.warmUpThree(workoutWeight: u.maxDeadlift)
        
        let wp1 = c.warmUpOne(workoutWeight: u.maxOHP)
        let wp2 = c.warmUpTwo(workoutWeight: u.maxOHP)
        let wp3 = c.warmUpThree(workoutWeight: u.maxOHP)
        
        let squatWarmup = [ws1, ws2, ws3]
        let benchWarmup = [wb1, wb2, wb3]
        let deadliftWarmup = [wd1, wd2, wd3]
        let pressWarmup = [wp1, wp2, wp3]
        
        
        let s11 = c.weekOneFirst(workoutWeight: u.maxSquat)
        let s12 = c.weekOneSecond(workoutWeight: u.maxSquat)
        let s13 = c.weekOneThird(workoutWeight: u.maxSquat)
        
        let s21 = c.weekTwoFirst(workoutWeight: u.maxSquat)
        let s22 = c.weekTwoSecond(workoutWeight: u.maxSquat)
        let s23 = c.weekTwoThird(workoutWeight: u.maxSquat)
        
        let s31 = c.weekThreeFirst(workoutWeight: u.maxSquat)
        let s32 = c.weekThreeSecond(workoutWeight: u.maxSquat)
        let s33 = c.weekThreeThird(workoutWeight: u.maxSquat)
       
        let squatOne = [s11, s12, s13]
        let squatTwo = [s21, s22, s23]
        let squatThree = [s31, s32, s33]
        let squatFour = [ws1, ws2, ws3]

        let b11 = c.weekOneFirst(workoutWeight: u.maxBench)
        let b12 = c.weekOneSecond(workoutWeight: u.maxBench)
        let b13 = c.weekOneThird(workoutWeight: u.maxBench)
        
        let b21 = c.weekTwoFirst(workoutWeight: u.maxBench)
        let b22 = c.weekTwoSecond(workoutWeight: u.maxBench)
        let b23 = c.weekTwoThird(workoutWeight: u.maxBench)
        
        let b31 = c.weekThreeFirst(workoutWeight: u.maxBench)
        let b32 = c.weekThreeSecond(workoutWeight: u.maxBench)
        let b33 = c.weekThreeThird(workoutWeight: u.maxBench)
        
        let benchOne = [b11, b12, b13]
        let benchTwo = [b21, b22, b23]
        let benchThree = [b31, b32, b33]
        let benchFour = [wb1, wb2, wb3]

        let d11 = c.weekOneFirst(workoutWeight: u.maxDeadlift)
        let d12 = c.weekOneSecond(workoutWeight: u.maxDeadlift)
        let d13 = c.weekOneThird(workoutWeight: u.maxDeadlift)
        
        let d21 = c.weekTwoFirst(workoutWeight: u.maxDeadlift)
        let d22 = c.weekTwoSecond(workoutWeight: u.maxDeadlift)
        let d23 = c.weekTwoThird(workoutWeight: u.maxDeadlift)
        
        let d31 = c.weekThreeFirst(workoutWeight: u.maxDeadlift)
        let d32 = c.weekThreeSecond(workoutWeight: u.maxDeadlift)
        let d33 = c.weekThreeThird(workoutWeight: u.maxDeadlift)
        
        let deadliftOne = [d11, d12, d13]
        let deadliftTwo = [d21, d22, d23]
        let deadliftThree = [d31, d32, d33]
        let deadliftFour = [wd1, wd2, wd3]
        
        let p11 = c.weekOneFirst(workoutWeight: u.maxOHP)
        let p12 = c.weekOneSecond(workoutWeight: u.maxOHP)
        let p13 = c.weekOneThird(workoutWeight: u.maxOHP)
        
        let p21 = c.weekTwoFirst(workoutWeight: u.maxOHP)
        let p22 = c.weekTwoSecond(workoutWeight: u.maxOHP)
        let p23 = c.weekTwoThird(workoutWeight: u.maxOHP)
        
        let p31 = c.weekThreeFirst(workoutWeight: u.maxOHP)
        let p32 = c.weekThreeSecond(workoutWeight: u.maxOHP)
        let p33 = c.weekThreeThird(workoutWeight: u.maxOHP)

        let pressOne = [p11, p12, p13]
        let pressTwo = [p21, p22, p23]
        let pressThree = [p31, p32, p33]
        let pressFour = [wp1, wp2, wp3]
    
        exerciseData = ExerciseData(
            data: [
                "Warmup": [
                    "Squat": squatWarmup,
                    "Bench": benchWarmup,
                    "Deadlift": deadliftWarmup,
                    "Press": pressWarmup,
                ],
                "Squat": [
                    "Week 1": squatOne,
                    "Week 2": squatTwo,
                    "Week 3": squatThree,
                    "Week 4": squatFour,
                ],
                "Bench": [
                    "Week 1": benchOne,
                    "Week 2": benchTwo,
                    "Week 3": benchThree,
                    "Week 4": benchFour,
                ],
                "Deadlift": [
                    "Week 1": deadliftOne,
                    "Week 2": deadliftTwo,
                    "Week 3": deadliftThree,
                    "Week 4": deadliftFour,
                ],
                "Press": [
                    "Week 1": pressOne,
                    "Week 2": pressTwo,
                    "Week 3": pressThree,
                    "Week 4": pressFour,
                ]
            ]
        )
    }

    var body: some View {
        VStack {
            // Picker for the exercises
            Picker("Select an exercise", selection: $selectedExercise) {
                ForEach(exercises, id: \.self) { exercise in
                    Text(exercise).tag(exercise)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Sections for each subtype's weights
            List {
                if selectedExercise == "Warmup" {
                    ForEach(["Squat", "Bench", "Deadlift", "Press"], id: \.self) { subtype in
                        Section(header: Text("\(subtype) Weights (lb)")) {
                            ForEach(exerciseData.weights(for: selectedExercise, subtype: subtype), id: \.self) { weight in
                                Text("\(weight)")
                            }
                        }
                    }
                } else {
                    ForEach(1...4, id: \.self) { week in
                        Section(header: Text("Week \(week) Weights")) {
                            ForEach(exerciseData.weights(for: selectedExercise, subtype: "Week \(week)"), id: \.self) { weight in
                                Text("\(weight)")
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
        .navigationTitle("\(selectedExercise) Weights")
        .onAppear(perform: populateExerciseData)
    }
}

struct Workout531View_Previews: PreviewProvider {
    static var previews: some View {
        Workout531View()
    }
}

