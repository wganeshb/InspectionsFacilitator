//
//  LoaderView.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 06/07/24.
//

import SwiftUI

struct LoaderView: View {
    
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}

#Preview {
    LoaderView()
}
