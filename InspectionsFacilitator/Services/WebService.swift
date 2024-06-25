//
//  WebService.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 21/06/24.
//

import Foundation

class WebService {
    
    private var baseURL = "http://127.0.0.1:5001"
    
    func submit(inspectionModelObject: InspectionsModelResponse) async throws -> Bool {
        
        let urlString = baseURL + URLEndpoint.submit
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(inspectionModelObject)
        } catch {
            throw ErrorCases.invalidData
        }
        
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ErrorCases.invalidResponse
        }
        
        return response.statusCode == 200
    }
    
    func register(email: String, password: String) async throws -> Bool {
        
        let params = [
            "email" : email,
            "password" : password
        ]
        
        let urlString = baseURL + URLEndpoint.register
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ErrorCases.invalidResponse
        }
        
        return response.statusCode == 200
    }
    
    func login(email: String, password: String) async throws -> Bool {
        
        let params = [
            "email" : email,
            "password" : password
        ]
        
        let urlString = baseURL + URLEndpoint.login
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ErrorCases.invalidResponse
        }
        
        return response.statusCode == 200
    }
    
    func getInspectionsList() async throws -> InspectionsModelResponse {
        let urlString = baseURL + URLEndpoint.inspections
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
        {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(InspectionsModelResponse.self, from: data)
        } catch {
            throw ErrorCases.invalidData
        }
    }
}
