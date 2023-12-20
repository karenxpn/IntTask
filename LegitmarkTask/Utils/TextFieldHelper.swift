//
//  TextFieldHelper.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import SwiftUI

struct TextFieldHelper: View {
    let placeholder: String
    var disabled: Bool = false
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textInputAutocapitalization(.never)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 245/255, green: 245/255, blue: 245/255).opacity(disabled ? 0.4 : 1))
            }
    }
}

#Preview {
    TextFieldHelper(placeholder: "Optional", disabled: true, text: .constant(""))
}
