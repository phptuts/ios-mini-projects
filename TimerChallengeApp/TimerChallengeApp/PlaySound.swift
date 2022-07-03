//
//  PlaySound.swift
//  TimerChallengeApp
//
//  Created by Noah Glaser on 6/28/22.
//

import Foundation

import AVKit

class PlayViewModel {
    
    private var audioPlayer: AVAudioPlayer!
    
    
    func play(fileNamed:String) {
        let sound = Bundle.main.path(forResource: fileNamed, ofType: "wav")
        
        audioPlayer?.prepareToPlay() //maybe not needed?  idk

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
}
