//
//  ContentView.swift
//  ColorPicker
//
//  Created by Noah Glaser on 6/1/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var red = 0.5
    @State var green = 0.0
    @State var blue = 0.0
    
    var color: Color {
        .init(red: red, green: green, blue: blue)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Color") {
                    HStack {
                        Spacer()
                        Rectangle()
                            .frame(width: 300, height: 200)
                            .foregroundColor(color)
                        Spacer()
                    }
                }
                HStack {
                    Spacer()
                    Text("Hex \(color.hexString())")
                    Spacer()
                }
                Section("Red -> \(red.toPercent())") {
                    Slider(value: $red)
                }
                Section("Green -> \(green.toPercent())") {
                    Slider(value: $green)
                }
                Section("Blue -> \(blue.toPercent())") {
                    Slider(value: $blue)
                }
            }.navigationTitle("Color Picker")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    func hexString() -> String {
        let components = self.cgColor?.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}

extension Double {
    func toPercent() -> String {
        String(format:"%6.2f%%",self * 100)
    }
}
