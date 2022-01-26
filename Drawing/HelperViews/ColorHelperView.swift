//
//  ColorView.swift
//  Drawing
//
//  Created by Dante Cesa on 1/25/22.
//

import SwiftUI

struct ColorHelperView: View {
    let colors: [(String, Color)] = DrawingAppColor.colors
    @Binding var selectedColor: Int
    
    var body: some View {
        Picker("Color", selection: $selectedColor) {
            ForEach(0..<colors.count) { index in
                Text(colors[index].0)
            }
        }.pickerStyle(.inline)
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorHelperView(selectedColor: .constant(0))
    }
}
