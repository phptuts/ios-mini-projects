//
//  ContentView.swift
//  AnimatedCount
//
//  Created by Noah Glaser on 6/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var degrees = 0.0
    @State var letterDegrees = 0.0
    @State var counter = 1
    
    var body: some View {
        NavigationView {
            VStack {
                    HStack {
                        Spacer()
                        Text("\(counter)")
                            .rotation3DEffect(.degrees(letterDegrees), axis: (x:1, y: 0, z:0  ))
                            .frame(width: 300, height: 300)
                            .foregroundColor(.red)
                            .background(.blue)
                            .font(.system(size: 100))
                            .rotation3DEffect(.degrees(degrees), axis: (x:1, y: 0, z: 0  ))
                            .animation(.easeIn(duration: 0.5), value: degrees)
                        Spacer()
                    }.padding()
                    HStack {
                        Spacer()
                        Button("Up") {
                            
                            degrees -= 180
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                counter += 1
                                letterDegrees -= 180
                            }
                        }.padding()
                            .background(.red)
                            .foregroundColor(.white)
                            .font(.title.bold())

                        Spacer()
                    }
                    Spacer()
                }.navigationTitle("Animated Counter")
            
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
