//
//  AuthViewModel.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
import SwiftUI

class AuthViewModel: AlertViewModel, ObservableObject {
    
    @AppStorage("token") private var token = ""
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var otpRequired: Bool = false
    @Published var email: String = ""
    @Published var otp: String = ""
    
    var manager: AuthServiceProtocol
    init(manager: AuthServiceProtocol = AuthService.shared) {
        self.manager = manager
    }
    
    @MainActor func registerUser() {
        loading = true
        Task {
            
            do {
                
                let result = try await manager.registerUser(email: email)
                if let token = result.access_token {
                    self.token = token
                } else {
                    otpRequired = true
                }
                
            } catch let error as NetworkError {
                self.makeNetworkAlert(with: error, message: &alertMessage, alert: &showAlert)
            }
            
            if !Task.isCancelled {
                loading = false
            }
        }
    }
    
    @MainActor func checkOTP() {
        loading = true
        
        Task {
            do {
                let result = try await manager.checkOTP(email: email, otp: otp)
                if let token = result.access_token {
                    self.token = token
                } else {
                    self.showAlert.toggle()
                    self.alertMessage = "Something went wrong."
                }
                
            } catch let error as NetworkError {
                self.makeNetworkAlert(with: error, message: &alertMessage, alert: &showAlert)
            }
            
            if !Task.isCancelled {
                loading = false
            }
        }
    }
}
