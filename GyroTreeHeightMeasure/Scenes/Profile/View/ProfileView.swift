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
                Text("Height: \(String(format: "%.0f", store.deviceHeight)) cm")
                Slider(value: $store.deviceHeight, in: 100...220, step: 1)
                    .tint(.green)
                    .padding(.horizontal)
                Button {
                    store.send(.saveProfile(store.deviceHeight))
                } label: {
                    Text("Save profile")
                }
                .foregroundColor(.green)
                .buttonStyle(BorderedButtonStyle())
            }
            .navigationTitle("Profile page")
        }
        .onAppear {
            // tu skusit potiahnut hodnotu z Profile Marcel pls check
            let defaults = UserDefaults.standard
            let UserGlobalDeviceHeight = defaults.value(forKey: "deviceHeight")
            //vyuzivam Marcelov trik na ulozenie do store
            //vyska je tu OK, ale nenastavi ju na slider
            store.send(.saveProfile(UserGlobalDeviceHeight as! Double))
        }
    }
}

#Preview {
    ProfileView(store: ProfileViewStore())
}
