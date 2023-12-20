//
//  Brand.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
struct BrandResponse: Codable, Hashable {
    var brands: [Brand]
}


struct Brand: Codable, Hashable {
    var uuid: String
    var name: String
}

struct BrandViewModel: Identifiable, Hashable {
    var model: Brand
    var id: String
    
    init(model: Brand) {
        self.model = model
        self.id = model.uuid
    }
    
    var name: String { self.model.name }
}
