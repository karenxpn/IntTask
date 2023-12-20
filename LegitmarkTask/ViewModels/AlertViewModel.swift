//
//  AlertViewModel.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
class AlertViewModel {
    
    func makeAlert(with error: Error, message: inout String, alert: inout Bool ) {
        message = error.localizedDescription
        alert.toggle()
    }
    
    func makeNetworkAlert(with error: NetworkError, message: inout String, alert: inout Bool ) {
        if let backendError = error.backendError {
            message = backendError.message
            alert.toggle()
        } else {
            self.makeAlert(with: error.initialError, message: &message, alert: &alert)
        }
    }
}
