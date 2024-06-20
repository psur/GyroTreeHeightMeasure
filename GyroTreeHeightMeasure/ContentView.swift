//
//  ContentView.swift
//  GyroTreeHeightMeasure
//
//  Created by Peter Surovy on 19.05.2024.
//

import SwiftUI
import CoreMotion
import AVFoundation

class Model: ObservableObject {
    @Published var OrientationX: Double = 0.0
    @Published var OrientationY: Double = 0.0
    @Published var OrientationZ: Double = 0.0
    
    @Published var distance: Double = 0.0
    @Published var SavedOrientationZ: Double = 0.0
}

var motion = CMMotionManager()

struct ContentView: View {
    @ObservedObject var model = Model()
    @State var orientationAngle = 0.0
    @State var measureSoundEffect1: AVAudioPlayer?
    
    var body: some View {
        
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
            
            Text("\(model.OrientationX), \(model.OrientationY), \(model.OrientationZ)")
            Text("Distance : \(model.distance)")
            Text("Measured Angle : \(orientationAngle)")
                
            Divider()
            Button(action: {readGyro5sec()}){
                Image("ButtonMeasure").resizable()
                    .frame(width: 300, height:200)
                    .cornerRadius(20.0)
            }.frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
           // eventSubject.send(.close)
           // logger.info("Onboarding button close tapped")

        }
        
        
        .padding()
        .onAppear(){
            self.MyGyro()
            
        }
    }
        
    
    
    func readGyro5sec(){
        let path = Bundle.main.path(forResource: "counter.mp3", ofType:nil)!
        let path2 = Bundle.main.path(forResource: "finish.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        let url2 = URL(fileURLWithPath: path2)
        do {
            measureSoundEffect1 = try AVAudioPlayer(contentsOf: url)
            //measureSoundEffect1 = try AVAudioPlayer(contentsOf: url2)
            measureSoundEffect1?.play()
        } catch {
            print("couldn't load file :(")
        }

        
        model.distance = 172 / tan((model.OrientationZ)*Double.pi/180)
        var sum:Double = 0
        var runCount = 0
       
       
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in

            if runCount < 3 {
                do {
                    measureSoundEffect1 = try AVAudioPlayer(contentsOf: url)
                    measureSoundEffect1?.play()
                } catch {
                    print("couldn't load file :(")
                }
            }
            
            print("Timer fired!")
            
            runCount += 1
            sum = sum + model.OrientationZ
            //AudioServicesPlaySystemSound(1333)
            
            
            
            //print(sum)no
            if runCount == 4 {
                timer.invalidate()
                model.SavedOrientationZ = sum / 20
                print(sum)
                orientationAngle = model.SavedOrientationZ
                //AudioServicesPlaySystemSound(1034)
                do {
                    measureSoundEffect1 = try AVAudioPlayer(contentsOf: url2)
                    measureSoundEffect1?.play()
                } catch {
                    print("couldn't load file :(")
                }
            }
        }
        
        
        
       
        //AudioServicesPlaySystemSound(1034)
    }
    
    func MyGyro(){
//        motion.accelerometerUpdateInterval = 0.5
//        motion.startAccelerometerUpdates(to:OperationQueue.current!){(data, error) in
//            if let trueData = data{
//                //print(data?.acceleration.x)
//                model.OrientationX = (data?.acceleration.x)!
//            }
//        }
        
        motion.deviceMotionUpdateInterval = 0.3
        motion.startDeviceMotionUpdates(to:OperationQueue.current!){(data, error) in
            if let trueData = data{
                //print(data?.acceleration.x)
                model.OrientationX = (data?.attitude.roll ?? 0)*180/Double.pi
                model.OrientationY = (data?.attitude.yaw ?? 0)*180/Double.pi
                model.OrientationZ = (data?.attitude.pitch ?? 0)*180/Double.pi
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}


