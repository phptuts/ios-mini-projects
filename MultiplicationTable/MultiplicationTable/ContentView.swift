//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Noah Glaser on 5/29/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var multiple = 3
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Stepper("Multiple \(multiple)", value: $multiple, in: 1...12)
                }
                List(1..<13) {
                    Text("\($0) x \(multiple) = \(multiple * $0)")
                }
            }.navigationTitle("Multiplication Table")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
