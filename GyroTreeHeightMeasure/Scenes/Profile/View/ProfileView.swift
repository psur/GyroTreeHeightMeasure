//
//  ProfileView.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 21.06.2024.
//

import SwiftUI

struct ProfileView: View {
    @Bindable var store = ProfileViewStore()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Height: \(String(format: "%.0f", store.height)) cm")
                Slider(value: $store.height, in: 100...220, step: 1)
                    .padding(.horizontal)
                Button {
                    store.send(.saveProfile(store.height))
                } label: {
                    Text("Save profile")
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .navigationTitle("Profile page")
        }
    }
}

#Preview {
    ProfileView(store: ProfileViewStore())
}
