//
//  Model.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
struct ModelResponse: Codable, Hashable {
    var models: [Model]
}

struct Model: Codable, Hashable {
    var uuid: String
    var name: String
    var brand: String
}

struct ModelViewModel: Identifiable, Hashable {
    var model: Model
    var id: String
    
    init(model: Model) {
        self.model = model
        self.id = model.uuid
    }
    
    var name: String    { self.model.name }
    var brand: String   { self.model.brand }
}
