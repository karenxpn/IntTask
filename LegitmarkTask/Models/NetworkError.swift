//
//  NetworkError.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var message: String
}
