//
//  LoginViewModel.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 20/06/24.
//

import Foundation

class LoginRegisterViewModel: ObservableObject {
    
    @Published var status: Bool = false
    @Published var error: ErrorCases?
    
    func login(email: String, password: String) async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        do {
            let loginStatus = try await WebService().login(email: email, password: password)
            await MainActor.run {
                self.status = loginStatus
            }
        } catch (let error) {
            await MainActor.run {
                self.status = false
                self.error = error as? ErrorCases
            }
        }
    }
    
    func register(email: String, password: String) async {
        do {
            let registerStatus = try await WebService().register(email: email, password: password)
            await MainActor.run {
                self.status = registerStatus
            }
        } catch (let error) {
            await MainActor.run {
                self.status = false
                self.error = error as? ErrorCases
            }
        }
    }
    
    
}

