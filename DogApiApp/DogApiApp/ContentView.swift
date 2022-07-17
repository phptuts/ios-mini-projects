//
//  ContentView.swift
//  DogApiApp
//
//  Created by Noah Glaser on 7/5/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dogBreeds: [String] = []
    
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            List(dogBreeds, id: \.self) { dogBreed in
                    NavigationLink {
                        DogView(dogBreed: dogBreed)
                    } label: {
                        Text(dogBreed.capitalized)
                    }
                
            }.navigationTitle("Dog Breeds")
        }.task {
            await getDogBreeds()
        }.alert("Error", isPresented: $showError) {
            Button("Ok") {
                
            }
        } message: {
            Text("There was an error fetching the dogs.  Sorry :(")
        }
    
    }
    
    func getDogBreeds() async {
        do {
            let responseJson: BreedResponse = try await getData(urlString: "https://dog.ceo/api/breeds/list/all")
            dogBreeds = responseJson.message.keys.map { $0 }.sorted()
        } catch {
            print(error)
            showError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
