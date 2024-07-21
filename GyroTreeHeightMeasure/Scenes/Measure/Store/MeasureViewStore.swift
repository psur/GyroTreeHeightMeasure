//
//  MeasureViewStore.swift
//  GyroTreeHeightMeasure
//
//  Created by Marcel Mravec on 22.06.2024.
//

import AVFoundation
import Combine
import CoreMotion
import Foundation
import os

@Observable final class MeasureViewStore: ObservableObject, Store {
    private let logger = Logger()
    private let eventSubject = PassthroughSubject<MeasureViewEvent, Never>()
    var eventPublisher: AnyPublisher<MeasureViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    var state: MeasureViewState = .initial
    struct DeviceOrientation {
        var orientationX: Double = 0.0
        var orientationY: Double = 0.0
        var orientationZ: Double = 0.0
    }
    
    var deviceOrientation = DeviceOrientation(orientationX: 0, orientationY: 0, orientationZ: 0)
    var distance: Double = 0.0
    var observationPointHeight = 172.0
    var height: Double = 0.0
    var treeHeight: Double {
        height + observationPointHeight
    }
    var savedOrientationZ: Double = 0.0
    var player: AVAudioPlayer?
    var motion = CMMotionManager()
    var measuredAngle: Double = 0.0
}

extension MeasureViewStore {
    @MainActor
    func send(_ action: MeasureViewAction) {
        switch action {
        case .measureDistance:
            measureDistance()
            self.state.status = .heightMeasure
        case .measureHeight:
            measureHeight()
        }
    }
    //I change name from startMeasure to measureDistance to be more readeable
    func measureDistance() {
        for _ in 1...5 {
            playSound("counter")
            sleep(1)
        }
        logger.info("Sound was played.")
        measuredAngle = (-1) * deviceOrientation.orientationZ * 180 / Double.pi
        distance = observationPointHeight / tan(-deviceOrientation.orientationZ)
        playSound("finish")
    }
    
    func measureHeight() {
        for _ in 1...5 {
            playSound("counter")
            sleep(1)
        }
        logger.info("Sound was played.")
        measuredAngle = (-1) * deviceOrientation.orientationZ * 180 / Double.pi
        height = distance * tan(deviceOrientation.orientationZ)
        playSound("finish")
    }
    
    func playSound(_ soundName: String) {
        
        guard let path = Bundle.main.path(forResource: soundName, ofType: "mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func readGyro() {
        motion.deviceMotionUpdateInterval = 0.5
        motion.startDeviceMotionUpdates(to: .main) { (data, error) in
            guard error == nil else {
                self.logger.error("\(error)")
                return
            }
            if let data {
                self.deviceOrientation.orientationX = data.attitude.roll
                self.deviceOrientation.orientationY = data.attitude.yaw
                self.deviceOrientation.orientationZ = data.attitude.pitch
            }
        }
    }
}
