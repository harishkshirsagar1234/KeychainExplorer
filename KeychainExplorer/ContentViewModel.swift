//
//  ContentViewModel.swift
//  KeychainExplorer
//
//  Created by Harish Kshirsagar on 07/03/25.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var age: String = ""
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var alertTitle: String = "Warning"

    func validateInputs() {
        if let errorMessage = getValidationError() {
            showAlert(title: "Warning", message: errorMessage)
        } else {
            showAlert(title: "Congrats", message: "Signup Successful!")
            saveToKeychain()
            fetchFromKeychain()
        }
    }

    private func getValidationError() -> String? {
        if username.isEmpty { return "Username cannot be empty." }
        if password.isEmpty { return "Please enter Password." }
        if password.count < 6 { return "Password must be at least 6 characters long." }
        if age.isEmpty { return "Please enter Age." }
        return nil
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }

    private func saveToKeychain() {
        do {
            try KeychainManager.saveData(
                service: username,
                account: age,
                password: password.data(using: .utf8) ?? Data()
            )
        } catch {
            print("Error saving to Keychain: \(error)")
        }
    }

    private func fetchFromKeychain() {
        guard let data = KeychainManager.getData(service: username, account: age) else { return }
        let savedPassword = String(decoding: data, as: UTF8.self)
        print("Retrieved Password: \(savedPassword)")
    }
}
