//
//  Service.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
protocol ServiceProtocol {
    func fetchBrands() async throws -> BrandResponse
    func fetchBrandModels(brandID: String) async throws -> ModelResponse
}

class Service {
    static let shared: ServiceProtocol = Service()
    private init() { }
}

extension Service: ServiceProtocol {
    func fetchBrands() async throws -> BrandResponse {
        let url = URL(string: "https://v2.dev.api.legitmark.com/api/brands")!
        return try await APIHelper.shared.request(url: url, responseType: BrandResponse.self)
    }
    
    func fetchBrandModels(brandID: String) async throws -> ModelResponse {
        let url = URL(string: "https://v2.dev.api.legitmark.com/api/brands/\(brandID)/models")!
        return try await APIHelper.shared.request(url: url, responseType: ModelResponse.self)
    }    
}
