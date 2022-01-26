//
//  ArrowView.swift
//  Drawing
//
//  Created by Dante Cesa on 1/25/22.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        let arrowHeadSharpness: CGFloat = 40
        let rectangleWidth: CGFloat = 40
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: 0)) // Start at top
        
        // Left side of Arrowhead
        path.addLine(to: CGPoint(x: 0, y: rect.midY  + arrowHeadSharpness)) // Left most corner
        path.addLine(to: CGPoint(x: rect.midX - rectangleWidth, y: rect.midY)) // Back to center
        
        // Rectangle
        path.addLine(to: CGPoint(x: rect.midX - rectangleWidth, y: rect.maxY)) // Draw a line to the left top corner to bottom left corner
        path.addLine(to: CGPoint(x: rect.midX + rectangleWidth, y: rect.maxY)) // Draw a line across from bottom left corner to bottom right corner
        path.addLine(to: CGPoint(x: rect.midX + rectangleWidth, y: rect.midY)) // Draw a line across from bottom right corner to top right corner
        
        // Right side of Arrowhead
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY + arrowHeadSharpness)) // Right most corner
        path.addLine(to: CGPoint(x: rect.midX, y: 0)) // Back to top
        
        return path
    }
}

struct ArrowView: View {
    @State var lineWidth: Double = 1
    @State var rotationAngle: Double = 0
    @State var selectedColor: Int = 4
    
    var body: some View {
        VStack(spacing: 50) {
            Arrow()
                .stroke(DrawingAppColor.colors[selectedColor].1, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(rotationAngle))
                .animation(.default, value: lineWidth)
                .animation(.default, value: rotationAngle)
                .frame(width: 300, height: 300)
                .onAppear {
                    lineWidth = 10
                    rotationAngle = 45
                }
            
            List {
                Text("Line Width: \(String(format: "%.0f", lineWidth)) px")
                Slider(value: $lineWidth, in: 1...25, label: { Text("Line Width") })
                
                Text("Rotation Angle: \(String(format: "%.0f", rotationAngle))˚")
                Slider(value: $rotationAngle, in: 0...360, label: { Text("Rotation Angle")})
                
                ColorHelperView(selectedColor: $selectedColor)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
