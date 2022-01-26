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
                
                NavigationLink("Arc", destination: { ArcView() })
                
                NavigationLink("Flower", destination: { FlowerView() })
                
                NavigationLink("RGB Circles", destination: { RGBCircles() })
            }
            .navigationTitle("Drawing 101")
        }.preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
