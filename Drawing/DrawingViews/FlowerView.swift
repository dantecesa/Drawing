//
//  Flower.swift
//  Drawing
//
//  Created by Dante Cesa on 1/25/22.
//

import SwiftUI

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(petalOffset, petalWidth) }
        set {
            petalOffset = newValue.first
            petalWidth = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct FlowerView: View {
    @State private var petalOffset: Double = -40
    @State private var petalWidth: Double = 0
    @State private var eoFillOn: Bool = false
    @State private var selectedColor: Int = 5
    
    var body: some View {
        VStack(spacing: 50) {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(DrawingAppColor.colors[selectedColor].1, style: FillStyle(eoFill: eoFillOn))
                .animation(.default, value: selectedColor)
                .animation(.default, value: petalOffset)
                .animation(.default, value: petalWidth)
                .frame(width: 300, height: 300)
                .onAppear {
                    petalOffset = 0
                    petalWidth = 36
                }
            
            List {
                Text("Offset: \(String(format: "%.0f", petalOffset))")
                Slider(value: $petalOffset, in: -40...40)
                
                Text("Width: \(String(format: "%0.f", petalWidth))")
                Slider(value: $petalWidth, in: 0...100)
                
                Section {
                    Toggle("Fill Style", isOn: $eoFillOn)
                }
                
                ColorHelperView(selectedColor: $selectedColor)
            }
        }.preferredColorScheme(.dark)
    }
}

struct Flower_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView()
    }
}
