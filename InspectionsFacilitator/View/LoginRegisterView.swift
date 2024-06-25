//
//  LoginRegisterView.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 20/06/24.
//

import SwiftUI

@Observable
class AppState: ObservableObject {
    var loggedInStatus: Bool = false
    var registeredStatus: Bool = (UserDefaults().value(forKey: "isRegistered") as? Bool) ?? false
}

struct LoginRegisterView: View {
    
    @StateObject var appState: AppState = AppState()
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginStatus: Bool = false
    @State private var incorrectCredentials = 0
    
    @ObservedObject var loginRegisterViewModel = LoginRegisterViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
                Text("Login status : \( (appState.loggedInStatus) ? "Logged in" : "Not logged in")")
                TextField("Username", text: $username)
                    .padding()
                    .frame(width:300.0 ,height: 50.0)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(5.0)
                    .border(.red, width: CGFloat(incorrectCredentials))
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width:300.0 ,height: 50.0)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(5.0)
                    .border(.red, width: CGFloat(incorrectCredentials))
                
                Button {
                    Task {
                        if appState.registeredStatus {
                            
                            print("Calling the login API with \(username) \(password)")
                            Utility().printDivider()
                            
                            await loginRegisterViewModel.login(email: username, password: password)
                            //await loginRegisterViewModel.login(email: "Ganesh@mail.com", password: "1234")
                            appState.loggedInStatus = loginRegisterViewModel.status
                        }
                        else {
                            print("Calling registation API with \(username) \(password)")
                            Utility().printDivider()
                            
                            await loginRegisterViewModel.register(email: username, password: password)
                            appState.registeredStatus = loginRegisterViewModel.status
                            if appState.registeredStatus {
                                UserDefaults.standard.setValue(true, forKey: "isRegistered")
                            }
                        }
                    }
                } label: {
                    Text("\( (appState.registeredStatus) ? "Login" : "Register")")
                }
                .padding()
                .foregroundColor(.white)
                .background(.blue.opacity(0.5))
                .cornerRadius(10.0)
                .border(.red, width: CGFloat(incorrectCredentials))
                .frame(width: 300.0, height: 50.0)
            }
            .navigationDestination(isPresented: $appState.loggedInStatus) {
                OperationsView()
            }
        }.environment(appState)
    }
}

#Preview {
    LoginRegisterView()
}
