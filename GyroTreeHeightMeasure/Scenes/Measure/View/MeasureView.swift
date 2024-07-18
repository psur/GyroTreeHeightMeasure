//
//  MeasureView.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 22.06.2024.
//

import SwiftUI

struct MeasureView: View {
    @Bindable var store = MeasureViewStore()
    var body: some View {
        VStack {
            
            Text("\(store.deviceOrientation.orientationX), \(store.deviceOrientation.orientationY), \(store.deviceOrientation.orientationZ)")
            Text("Distance : \(store.distance)")
            Text("Measured Angle : \(store.measuredAngle)")
                
            Divider()
            Button(action: { store.send(.startMeasure)}){
                Image("ButtonMeasure").resizable()
                    .frame(width: 300, height:200)
                    .cornerRadius(20.0)
            }.frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
        }
        .padding()
        .onAppear {
            store.readGyro()
        }
    }
}

#Preview {
    MeasureView()
}
