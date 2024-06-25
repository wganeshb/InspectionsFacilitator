//
//  ContentView.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 22/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var loggedInStatus: Bool = false
    
    @StateObject var envObject: AppState = AppState()
    
    var body: some View {
        
        NavigationView {
            VStack {
                if loggedInStatus {
                    LoginRegisterView(loginRegisterViewModel: LoginRegisterViewModel())
                }
            }
        }.environment(envObject)
    }
}

#Preview {
    ContentView()
}
