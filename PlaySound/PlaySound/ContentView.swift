//
//  ContentView.swift
//  PlaySound
//
//  Created by Noah Glaser on 7/2/22.
//

import SwiftUI
import AVFoundation

struct Sound {
    var file: String
    var ext: String
    var link: String
    
    var soundFile: String {
        "\(file).\(ext)"
    }
}


struct SoundView: View {
    let sound: Sound
    
    var body: some View {
        VStack {
            Text(sound.file)
                .font(.title)
                .foregroundColor(.white)
                .padding()
            Link("Download Link", destination: URL(string: sound.link)!)
                .font(.title)
                .padding()
            
        }
        
    }
}

struct ContentView: View {
    
    @State var audioPlayer: AVAudioPlayer?
    
    @State var lastSound: Sound?
    
    let sounds = [
        Sound(
            file: "slide_whistle",
         ext: "wav",
         link: "https://freesound.org/people/InspectorJ/sounds/410803/"),
        Sound(
            file: "comedic_whistle",
         ext: "wav",
         link: "https://freesound.org/people/InspectorJ/sounds/345687/"),
        Sound(file: "fart", ext: "mp3", link: "https://freesound.org/people/IFartInUrGeneralDirection/sounds/64532/")
    ]
    
    var body: some View {
        ZStack {
            Color.mint.ignoresSafeArea()
            VStack {
                Text("Random Sounds")
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                
                Button("Play") {
                    playRandomSound()
                }
                .padding()
                .font(.system(size: 40))
                .foregroundColor(.white)
                .background(.blue)
                if let lastSound = lastSound {
                    SoundView(sound: lastSound)
                }
                Spacer()
            }
            
        }
    }
    
    func playRandomSound() {
        audioPlayer = nil
        
        lastSound = sounds.randomElement()!
        
        
        if let url = Bundle.main.url(forResource: lastSound?.file, withExtension: lastSound?.ext) {
            do {
                audioPlayer = try AVAudioPlayer.init(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()

            } catch {
                print("ERROR", error)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
