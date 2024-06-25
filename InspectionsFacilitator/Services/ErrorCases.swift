//
//  ErrorCases.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 21/06/24.
//

import Foundation

enum ErrorCases: LocalizedError {
    case invalidUrl
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
            case .invalidUrl: return "Invalid URL found"
            case .invalidResponse: return "Invalid response found"
            case .invalidData: return "Invalid data found"
        }
    }
    
}
