//
//  NetworkServiceError.swift
//  table-app
//
//  Created by Alexandr Kozorez on 23.02.2022.
//

import Foundation

enum NetworkServiceError: Error {
    case network
    case decodable
    case unknown
    
    var message: String {
        switch self {
            case .decodable: return "Parsing error"
            case .network: return "Network error"
            case .unknown: return "Unknown error"
        }
    }
}
