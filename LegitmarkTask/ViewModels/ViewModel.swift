//
//  ViewModel.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
import Combine

class ViewModel: AlertViewModel, ObservableObject {
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var brands = [BrandViewModel]()
    @Published var models = [ModelViewModel]()
    
    @Published var selectedBrand: BrandViewModel?
    @Published var selectedModel: ModelViewModel?
    @Published var style: String = ""
    @Published var sku: String = ""
    
    var manager: ServiceProtocol
    init(manager: ServiceProtocol = Service.shared) {
        self.manager = manager
    }
    
    @MainActor func getBrands() {
        loading = true
        
        Task {
            do {
                let result = try await manager.fetchBrands()
                self.brands = result.brands.map(BrandViewModel.init)
            } catch let error as NetworkError {
                self.makeNetworkAlert(with: error, message: &alertMessage, alert: &showAlert)
            }
            
            if !Task.isCancelled {
                loading = false
            }
        }
    }
    
    @MainActor func getBrandModels(id: String) {
        loading = true
        Task {
            
            do {
                let result = try await manager.fetchBrandModels(brandID: id)
                self.models = result.models.map(ModelViewModel.init)
            } catch let error as NetworkError {
                self.makeNetworkAlert(with: error, message: &alertMessage, alert: &showAlert)
            }
            
            if !Task.isCancelled {
                loading = false
            }
        }
    }
}
