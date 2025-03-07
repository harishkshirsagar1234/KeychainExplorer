//
//  FloatingTextField.swift
//  KeychainExplorer
//
//  Created by Harish Kshirsagar on 07/03/25.
//

import SwiftUI

struct FloatingTextField: View {
    var textfieldType: String = "Username"
    @Binding var text: String
    @State private var isFocused: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(textfieldType)
                .font(.caption)
                .foregroundColor(isFocused || !text.isEmpty ? .blue : .gray)
                .offset(y: isFocused || !text.isEmpty ? -20 : 0)
                .animation(.easeInOut, value: isFocused || !text.isEmpty)

            TextField("", text: $text, onEditingChanged: { editing in
                isFocused = editing
            })
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10)
                .stroke(isFocused ? Color.blue : Color.gray, lineWidth: 2))
        }
        .padding(20)
    }
}

