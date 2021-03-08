//
//  SoundPlayer.swift
//  SprintTimer-v1
//
//  Created by Jack Smith on 2/13/21.
//

import AVFoundation
//var audioPlayer: AVAudioPlayer?

class SoundPlayer {

    /// Adding ref here will cause sounds to sometimes not play.
    /// Adding ref to the global scope (as in just below imports) works.
    /// The big downside to a global ref is you only get one sound so I can't have a bg sound or multiple sounds.
    /// The "No factory registered" error seems to only be related to simulators.
    var audioPlayer: AVAudioPlayer? // Or var audioPlayer: AVAudioPlayer!

    func Play(sound: String, type: String, loop: Int = 0, volume: Float = 1) {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
        try? AVAudioSession.sharedInstance().setActive(true)

        /// This one also works to play sounds but doesn't support playing in the background.
        //try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        //try? AVAudioSession.sharedInstance().setActive(true)
        
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.numberOfLoops = loop
                audioPlayer?.setVolume(volume, fadeDuration: 1)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("SoundPlayer Error")
            }
        }
    }
    
    func StopSound() {
        audioPlayer?.stop()
    }

}
