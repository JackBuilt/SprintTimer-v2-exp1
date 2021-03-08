//
//  TimerSounds.swift
//  SprintTimer-v1
//
//  Created by Jack Smith on 2/13/21.
//

import SwiftUI

enum sounds {
    case heartbeat
    case bgsound
    case intervalStart
    case workoutCompleted
}

class TimerSounds {
    
    private var soundPlayer: SoundPlayer = SoundPlayer()
    
    func Stop() {
        soundPlayer.StopSound()
    }
    
    func Play(_ sound: sounds, _ mute: Bool = false, loop: Int = 0) {

        if mute {
            print("sound muted")
            return
        }

        switch sound {
            case .heartbeat:
                soundPlayer.Play(sound: "heartbeat", type: "mp3", loop: loop)

            case .bgsound:
                soundPlayer.Play(sound: "heartbeat", type: "mp3", loop: loop)
                //soundPlayer.Play(sound: "one-minute-of-silence", type: "mp3", loop: loop)
                
            case .intervalStart:
                soundPlayer.Play(sound: "sound-start-interval", type: "mp3", loop: loop)
                
            case .workoutCompleted:
                soundPlayer.Play(sound: "workout-completed", type: "wav", loop: loop)
            
        }
    }
    
}
