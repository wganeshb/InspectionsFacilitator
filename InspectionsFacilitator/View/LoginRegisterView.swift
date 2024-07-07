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
    @State private var incorrectCredentials = 0
    
    @State var showActivity = true
    @State var showAlertOnRegisterFail = false
    
    @ObservedObject var loginRegisterViewModel = LoginRegisterViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
	                HStack {
                    Text("\((appState.registeredStatus) ? "Login" : "Register")")
                        .font(.largeTitle)
                        .padding()
                    LoaderView(tintColor: .blue, scaleSize: 1.0).hidden(showActivity)
                }
                
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
                        
                        self.showActivity = !self.showActivity
                        
                        if appState.registeredStatus {
                            
                            try? await Task.sleep(nanoseconds: 3_000_000_000)
                            
                            await loginRegisterViewModel.login(email: username, password: password)
                            appState.loggedInStatus = loginRegisterViewModel.status
                            self.showActivity = loginRegisterViewModel.status
                            
                            if !appState.loggedInStatus {
                                self.showAlertOnRegisterFail = true
                                self.showActivity = true
                                password = ""
                            }
                        }
                        else {
                            
                            try? await Task.sleep(nanoseconds: 3_000_000_000)
                            
                            await loginRegisterViewModel.register(email: username, password: password)
                            appState.registeredStatus = loginRegisterViewModel.status
                            self.showActivity = !self.showActivity
                            
                            if appState.registeredStatus {
                                UserDefaults.standard.setValue(true, forKey: "isRegistered")
                                password = ""
                            }
                            else {
                                self.showAlertOnRegisterFail = true
                            }
                        }
                    }
                } label: {
                    Text("\( (appState.registeredStatus) ? "Login" : "Register")")
                }
                .alert(isPresented: $showAlertOnRegisterFail, content: {
                    Alert(title: Text("Alert"),
                          message: Text("\((loginRegisterViewModel.error != nil) ? loginRegisterViewModel.error!.localizedDescription : "Invalid response")"),//Text("Invalid response. Please check the credentials"),
                          dismissButton: .default(Text("Close")))
                })
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
