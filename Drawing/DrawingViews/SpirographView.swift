//
//  SpirographView.swift
//  Drawing
//
//  Created by Dante Cesa on 1/26/22.
//

import SwiftUI

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    var amount: Double
    
    var animatableData: Double {
        get { amount }
        set { amount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
}

struct SpirographView: View {
    @State private var innerRadius: Double = 125.0
    @State private var outerRadius: Double = 75.0
    @State private var distance: Double = 25.0
    @State private var amount: Double = 0
    @State private var amountZero: Double = 0
    @State private var hue: Double = 0.6
    @State private var toggleAmount: Bool = true
    
    var body: some View {
        VStack(spacing: 50) {
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: toggleAmount ? amount : amountZero)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .animation(.default.delay(0.25), value: amount)
                .frame(width: 300, height: 300)
                .onAppear {
                    withAnimation(.default.delay(1).speed(0.01)) {
                        amount = 1
                    }
                }
            
            List {
                Text("Amount")
                Slider(value: toggleAmount ? $amount : $amountZero)
                
                Text("Inner Radius: \(String(format: "%.0f", innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                
                Text("Outer Radius: \(String(format: "%.0f", outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                
                Text("Distance: \(String(format: "%.0f", distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                
                Text("Color")
                Slider(value: $hue)
            }
        }
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Toggle Drawing") {
                    withAnimation {
                        toggleAmount.toggle()
                    }
                }
            }
        }
    }
}

struct SpirographView_Previews: PreviewProvider {
    static var previews: some View {
        SpirographView()
    }
}
