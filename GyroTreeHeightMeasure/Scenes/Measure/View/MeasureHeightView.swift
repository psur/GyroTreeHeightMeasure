//
//  MeasureHeightView.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 20.07.2024.
//

import Combine
import SwiftUI

struct MeasureHeightView: View, EventEmitting {
    
    typealias Event = MeasureViewEvent
    private let eventSubject = PassthroughSubject<MeasureViewEvent, Never>()
    
    @Bindable var store = MeasureViewStore()
    var body: some View {
        VStack {
            Text("\(store.deviceOrientation.orientationX), \(store.deviceOrientation.orientationY), \(store.deviceOrientation.orientationZ)")
            Text("Distance to tree: \(store.distance)")
            Text("Measured Angle: \(store.measuredAngle)")
            Text("Height from point of observation: \(store.treeHeight)")
            Text("Height of tree/object: \(store.treeHeight)")
            Button(action: { eventSubject.send(.finishedHeightMeasure)}){
                LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height:200)
                    .cornerRadius(20.0)
            }.frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
            Divider()
            Button(action: { store.send(.measureHeight)}){
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

extension MeasureHeightView {
    var eventPublisher: AnyPublisher<Event, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}


#Preview {
    MeasureHeightView()
}
