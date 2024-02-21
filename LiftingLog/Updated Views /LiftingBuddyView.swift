//
//  LiftingBuddy.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/16/24.
//

import SwiftUI
import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    
    func sendMessage(_ message: String) {
        let userMessage = ChatMessage(message: message, isFromUser: true)
        DispatchQueue.main.async {
            self.messages.append(userMessage)
        }
        
        // Prepare the URL and URLRequest for OpenAI
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Replace "Your_OpenAI_API_Key" with your actual OpenAI API key
        request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        
        // Prepare the body with your message. Adjust according to OpenAI's expected parameters.
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo", // Adjust the model as per your requirement
            "messages": [
                ["role": "user", "content": message]
            ]
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        // Make the API call
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error contacting OpenAI: \(error)")
                return
            }
            
            // Ensure data is received
            guard let data = data else {
                print("No data received from OpenAI")
                return
            }
            
            // Attempt to decode the response and catch any errors
            do {
                let chatResponse = try JSONDecoder().decode(OpenAIChatResponse.self, from: data)
                if let reply = chatResponse.choices.first?.text {
                    let botResponse = ChatMessage(message: reply, isFromUser: false)
                    DispatchQueue.main.async {
                        self.messages.append(botResponse)
                    }
                } else {
                    print("No reply found in the response")
                }
            } catch {
                print("Error decoding the response from OpenAI: \(error)")
                // If possible, log the raw JSON response to further diagnose the issue
                if let rawJSON = String(data: data, encoding: .utf8) {
                    print("Raw JSON received: \(rawJSON)")
                }
            }
        }
        task.resume()
    }


}
struct LiftingBuddyView: View {
    @State private var newMessageText: String = ""
    @ObservedObject private var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollView in
                    ForEach(viewModel.messages) { message in
                        HStack {
                            if message.isFromUser {
                                Spacer()
                                Text(message.message)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            } else {
                                Text(message.message)
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        withAnimation {
                            scrollView.scrollTo(viewModel.messages.last?.id)
                        }
                    }
                }
            }
            
            HStack {
                TextField("Type a message...", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(20))
                
                Button(action: {
                    viewModel.sendMessage(newMessageText)
                    newMessageText = ""
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
            }.padding()
        }
        .navigationTitle("Lifting Buddy")
    }
}
struct ChatMessage: Identifiable {
    let id: UUID = UUID()
    let message: String
    let isFromUser: Bool
}

struct ChatResponse: Decodable {
    let reply: String
}

struct OpenAIChatResponse: Decodable {
    let choices: [Choice]
    
    struct Choice: Decodable {
        let text: String // OpenAI's response contains a 'text' field, not a nested 'message' object
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        LiftingBuddyView()
    }
}

#Preview {
    LiftingBuddyView()
}
