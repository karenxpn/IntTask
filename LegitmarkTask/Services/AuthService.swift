//
//  AuthService.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
import Combine

protocol AuthServiceProtocol {
    func registerUser(email: String) async throws -> AuthModel
    func checkOTP(email: String, otp: String) async throws -> AuthModel
}

class AuthService {
    static let shared: AuthServiceProtocol = AuthService()
    private init() { }
}

extension AuthService: AuthServiceProtocol {
    func registerUser(email: String) async throws -> AuthModel {
        let url = URL(string: "https://v2.dev.api.legitmark.com/api/auths/register?pwl=true")!
        let params = [
            "email": email
        ]
        return try await APIHelper.shared.requestWithBody(url: url,
                                                          params: params,
                                                          method: .post,
                                                          responseType: AuthModel.self)
    }
    
    func checkOTP(email: String, otp: String) async throws -> AuthModel {
        let url = URL(string: "https://v2.dev.api.legitmark.com/api/auths/verify-otp")!
        let params = [
            "email": email,
            "otp": otp
        ]
        return try await APIHelper.shared.requestWithBody(url: url,
                                                          params: params,
                                                          method: .post,
                                                          responseType: AuthModel.self)
    }
    
    
}
