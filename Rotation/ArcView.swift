//
//  ArcView.swift
//  Drawing
//
//  Created by Dante Cesa on 1/25/22.
//

import SwiftUI

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: Double = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ArcView: View {
    @State private var startAngle: Double = 0
    @State private var endAngle: Double = 270
    
    var body: some View {
        VStack(spacing: 50) {
            Arc(startAngle: .degrees(startAngle), endAngle: .degrees(endAngle), clockwise: true)
                .stroke(.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
            
            List {
                Text("Start Angle: \(String(format: "%.0f", startAngle))")
                Slider(value: $startAngle, in: 0...360, label: { Text("Start Angle") })
                
                Text("End Angle: \(String(format: "%.0f", endAngle))")
                Slider(value: $endAngle, in: 0...360, label: { Text("End Angle") })
            }
        }.preferredColorScheme(.dark)
    }
}

struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ArcView()
    }
}
