//
//  LoginViewModel.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 20/06/24.
//

import Foundation

class LoginRegisterViewModel: ObservableObject {
    
    @Published var status: Bool = false
    
    func login(email: String, password: String) async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            let loginStatus = try await WebService().login(email: email, password: password)
            await MainActor.run {
                self.status = loginStatus
            }
            Utility().printDivider()
            print("Login status : ", self.status)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func register(email: String, password: String) async {
        do {
            let registerStatus = try await WebService().register(email: email, password: password)
            await MainActor.run {
                self.status = registerStatus
            }
            Utility().printDivider()
            print("Register status : ", self.status)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    
}

