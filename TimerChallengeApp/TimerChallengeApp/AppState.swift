//
//  AppState.swift
//  TimerChallengeApp
//
//  Created by Noah Glaser on 6/26/22.
//

import Foundation

enum Mode: String, Equatable {
    case rest = "Rest"
    case session = "Session"
}

struct AppState {
    var workMinutes: Int = 1 {
        didSet {
            if mode == .session {
                currentTime = workMinutes * 60
            }
        }
    }
    
    var restMinutes: Int = 5 {
        didSet {
            if mode == .rest {
                currentTime = restMinutes * 60
            }
        }
    }
    
    var mode = Mode.session
    
    var currentTime: Int
    
    var playSound: () -> Void
    
    init(playSound: @escaping () -> Void) {
        self.currentTime = workMinutes * 10
        self.playSound = playSound
    }
    
    var currentTimeDisplay: String {
        let minutes = currentTime / 60
        let secondsLeft = currentTime % 60
        return "\(minutes):\(secondsLeft < 10 ? "0" : "")\(secondsLeft)"

    }
    
    mutating func next() {
        
        if currentTime > 0 {
            currentTime -= 1
            return
        }
        
        if currentTime == 0 {
            playSound()
        }
        
        switch(mode) {
            case .session:
                currentTime = self.restMinutes * 60
                mode = .rest
                break
            case .rest:
                currentTime = self.workMinutes * 60
                mode = .session
        }
        
    }
    
    mutating func reset() {
        restMinutes = 5
        workMinutes = 25
        mode = .session
    }
}
