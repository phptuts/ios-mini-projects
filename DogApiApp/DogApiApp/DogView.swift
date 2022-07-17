//
//  Dog.swift
//  DogApiApp
//
//  Created by Noah Glaser on 7/6/22.
//

import SwiftUI

struct CustomProgressView: View {
    
    var body: some View {
        ProgressView()
            .frame(width: 400, height: 300)
            .background(Color.init(white: 0.9))
            .padding()
    }
}

struct DogView: View {
    
    let dogBreed: String
    
    @State var urlString: String?
    
    @State var showError = false
    
    var body: some View {
        VStack {
            if urlString != nil {
                AsyncImage(url: URL(string: urlString!)) { phase in
                    if let error = phase.error {
                        Text("Error loading image \(error.localizedDescription)")
                    }
                    
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 300)
                            .padding()
                    } else {
                        CustomProgressView()
                    }
                }
            } else {
                CustomProgressView()
            }
            Button("New Picture") {
                Task {
                    await getDogUrl()
                }
            }.padding()
            Spacer()
        }.navigationTitle(dogBreed.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await getDogUrl()
        }
        .alert("Error Loading", isPresented: $showError) {
            Button("OK") {
                
            }
        } message: {
            Text("Network error sorry :(")
        }
    }
    
    func getDogUrl() async {
        urlString = nil
        do {
            let responseJson: SingleImageResponse = try await getData(urlString: "https://dog.ceo/api/breed/\(dogBreed)/images/random?blah=\(Int.random(in: 1...10000))")
            urlString = responseJson.message
        } catch {
            print(error)
            showError = true
        }
    }
}

struct Dog_Previews: PreviewProvider {
    static var previews: some View {
        DogView(dogBreed: "Lab")
    }
}
