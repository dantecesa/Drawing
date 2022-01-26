//
//  ContentView.swift
//  Drawing
//
//  Created by Dante Cesa on 1/25/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Triangle", destination: { TriangleView() })
                
                NavigationLink("Arrow", destination: { ArrowView() })
                
                NavigationLink("Arc", destination: { ArcView() })
                
                NavigationLink("Flower", destination: { FlowerView() })
                
                NavigationLink("RGB Circles", destination: { RGBCircles() })
                
                NavigationLink("Spirograph", destination: { SpirographView() })
            }
            .padding(.top, 10)
            .navigationTitle("Drawing 101")
            
            TriangleView()
            
        }.preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
