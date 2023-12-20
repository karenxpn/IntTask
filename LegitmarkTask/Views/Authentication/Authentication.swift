//
//  Authentication.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import SwiftUI

struct Authentication: View {
    @StateObject private var authVM = AuthViewModel()
    var body: some View {
        
        VStack(spacing: 15) {
            
            TextFieldHelper(placeholder: "Email", text: $authVM.email)
            
            if authVM.otpRequired {
                TextFieldHelper(placeholder: "OTP", text: $authVM.otp)
                    .keyboardType(.numberPad)
            }
            
            ButtonHelper(disabled: !authVM.email.isEmail || (authVM.otpRequired && authVM.otp.isEmpty), label: "Continue") {
                
                authVM.otpRequired ? authVM.checkOTP() : authVM.registerUser()                
            }
            
        }.padding(24)
    }
}

#Preview {
    Authentication()
}
