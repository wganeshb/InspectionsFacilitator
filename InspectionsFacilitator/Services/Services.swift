//
//  Services.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 21/06/24.
//

import Foundation

class Services {
    
    private var baseURL = "http://127.0.0.1:5001"
    
    //func login(username: String, password: String) {
    func login() {
        guard let url = URL(string: baseURL + URLEndpoint.login) else { return }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postParams = ["email": "johnd@email.com", "password": "dogsname2015"]
        
        let jsonEncoder = JSONEncoder()
        do {
            urlRequest.httpBody = try jsonEncoder.encode(postParams)
        } catch {
            print("Post data encoding error")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else { return }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                print("bad url response")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Failed with status code \(httpResponse.statusCode)")
                return
            }
            print("DEBUG: InspectionViewModel decoded \(httpResponse.statusCode)")
            
        }.resume()
    }
    
    func register() {
        guard let url = URL(string: baseURL + URLEndpoint.register) else { return }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postParams = ["email": "ganesh@gmail.com", "password": "myName0210"]
        
        let jsonEncoder = JSONEncoder()
        do {
            urlRequest.httpBody = try jsonEncoder.encode(postParams)
        } catch {
            print("Post data encoding error")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else { return }
            
            //guard let inspectionViewModel = try? JSONDecoder().decode(InspectionsModel.self, from: data) else { return }
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                print("bad url response")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Failed with status code \(httpResponse.statusCode)")
                return
            }
            print("DEBUG: InspectionViewModel decoded \(httpResponse.statusCode)")
            
        }.resume()
    }
}
