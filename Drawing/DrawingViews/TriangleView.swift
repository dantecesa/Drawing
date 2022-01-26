//
//  TriangleView.swift
//  Drawing
//
//  Created by Dante Cesa on 1/25/22.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
                
        return path
    }
}

struct TriangleView: View {
    @State var strokeLineWidth: Double = 20
    @State var rotationSlider: Double = 0
    @State var selectedColor: Int = 1
    
    var body: some View {
        VStack(spacing: 50) {
            Triangle()
                .stroke(DrawingAppColor.colors[selectedColor].1, style: StrokeStyle(lineWidth: strokeLineWidth, lineCap: .round, lineJoin: .round))
                .animation(.interpolatingSpring(stiffness: 50, damping: 5), value: strokeLineWidth)
                .rotationEffect(.degrees(rotationSlider))
                .animation(.default, value: rotationSlider)
                .frame(width: 200, height: 200)
                
                .padding()
            
            List {
                Text("Line Width: \(String(format: "%.0f", strokeLineWidth)) px")
                Slider(value: $strokeLineWidth, in: 1...50) {
                    Text("Line width")
                }
                
                Text("Rotation: \(String(format: "%.0f", rotationSlider))˚")
                Slider(value: $rotationSlider, in: 0...360) {
                    Text("Rotation")
                        .foregroundColor(.white)
                }
                
                ColorHelperView(selectedColor: $selectedColor)
            }
            
        }.preferredColorScheme(.dark)
    }
}

struct TriangleView_Previews: PreviewProvider {
    static var previews: some View {
        TriangleView()
    }
}
