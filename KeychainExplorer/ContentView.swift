//
//  ContentView.swift
//  KeychainExplorer
//
//  Created by Harish Kshirsagar on 05/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var attributedText: AttributedString {
        var text = AttributedString("Create Account")
        text.foregroundColor = .blue
        if let range = text.range(of: "Account") {
            text[range].foregroundColor = .purple
        }
        return text
    }

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple.opacity(0.5)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Form Card
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 10)
                .frame(height: 500)
                .padding(20)
                .overlay(
                    VStack(spacing: 16) {
                        Text(attributedText)
                            .font(.title)
                            .bold()

                        FloatingTextField(text: $viewModel.username)
                        FloatingTextField(textfieldType: "Password", text: $viewModel.password)
                        FloatingTextField(textfieldType: "Age", text: $viewModel.age)

                        Button("Submit") {
                            viewModel.validateInputs()
                        }
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    }
                    .padding(.horizontal, 20)
                )
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    ContentView()
}
