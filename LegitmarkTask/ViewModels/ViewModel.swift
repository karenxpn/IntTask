//
//  ViewModel.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
import Combine

class ViewModel: AlertViewModel, ObservableObject {
    
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
        Task {
            do {
                let result = try await manager.fetchBrands()
                self.brands = result.brands.map(BrandViewModel.init)
            } catch let error as NetworkError {
                self.makeNetworkAlert(with: error, message: &alertMessage, alert: &showAlert)
            }
        }
    }
    
    @MainActor func getBrandModels(id: String) {
        Task {
            
            do {
                let result = try await manager.fetchBrandModels(brandID: id)
                self.models = result.models.map(ModelViewModel.init)
            } catch let error as NetworkError {
                self.makeNetworkAlert(with: error, message: &alertMessage, alert: &showAlert)
            }
        }
    }
}
