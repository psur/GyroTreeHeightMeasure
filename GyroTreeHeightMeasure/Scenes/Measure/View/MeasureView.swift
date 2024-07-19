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
            switch store.state.status {
            case .initial:
                Text("\(store.deviceOrientation.orientationX), \(store.deviceOrientation.orientationY), \(store.deviceOrientation.orientationZ)")
                Text("Distance: \(store.distance)")
                Text("Measured Angle: \(store.measuredAngle)")
                
                Divider()
                Button(action: { store.send(.startMeasure)}){
                    Image("ButtonMeasure").resizable()
                        .frame(width: 300, height:200)
                        .cornerRadius(20.0)
                }.frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
            case .heightMeasure:
                Text("\(store.deviceOrientation.orientationX), \(store.deviceOrientation.orientationY), \(store.deviceOrientation.orientationZ)")
                Text("Distance to tree: \(store.distance)")
                Text("Measured Angle: \(store.measuredAngle)")
                Text("Height from point of observation: \(store.treeHeight)")
                Text("Height of tree/object: \(store.treeHeight)")
                Divider()
                Button(action: { store.send(.measureHeight)}){
                    Image("ButtonMeasure").resizable()
                        .frame(width: 300, height:200)
                        .cornerRadius(20.0)
                }.frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
            }
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
