//
//  ProfileView.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack {
            Text("Profile page")
            Button {
                // code
            } label: {
                Text("Save profile")
            }
            .buttonStyle(BorderedButtonStyle())
        }
    }
}

#Preview {
    ProfileView()
}
