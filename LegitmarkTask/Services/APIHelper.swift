//
//  APIHelper.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
import Alamofire

class APIHelper {
    static let shared = APIHelper()
    
    func request<T>(url: URL,
                    method: HTTPMethod = .get,
                    responseType: T.Type) async throws -> T where T : Decodable {
        
        do {
            return try await withUnsafeThrowingContinuation({ continuation in
                AF.request(url,
                           method: method)
                .validate()
                .responseDecodable(of: T.self) { response in
                    
                    if response.error != nil {
                        response.error.map { err in
                            let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                            continuation.resume(throwing: NetworkError(initialError: err, backendError: backendError))
                        }
                    }
                    
                    if let registered = response.value {
                        continuation.resume(returning: registered)
                    }
                }
            })
        } catch {
            throw error
        }
    }
    
    func requestWithBody<T, P>(url: URL,
                               params: P,
                               method: HTTPMethod = .post,
                               responseType: T.Type) async throws -> T where T : Decodable, P : Encodable {
        
        
        do {
            return try await withUnsafeThrowingContinuation({ continuation in
                AF.request(url,
                           method: method,
                           parameters: params,
                           encoder: JSONParameterEncoder.default)
                .validate()
                .responseDecodable(of: T.self) { response in
                    
                    if response.error != nil {
                        response.error.map { err in
                            let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                            continuation.resume(throwing: NetworkError(initialError: err, backendError: backendError))
                        }
                    }
                    
                    if let registered = response.value {
                        continuation.resume(returning: registered)
                    }
                }
            })
        } catch {
            throw error
        }
    }
}
