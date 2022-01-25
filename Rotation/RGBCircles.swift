//
//  RGBCircles.swift
//  Rotation
//
//  Created by Dante Cesa on 1/22/22.
//

import SwiftUI

struct RGBCircles: View {
    @State var amount = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom))
                    .frame(width: 200 * amount, height: 200)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(.green)
                    .frame(width: 200 * amount, height: 200)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(.blue)
                    .frame(width: 200 * amount, height: 200)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct RGB_Previews: PreviewProvider {
    static var previews: some View {
        RGBCircles()
    }
}
