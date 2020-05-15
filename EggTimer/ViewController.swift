//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eggProgressBar: UIProgressView!
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    // Create variable for the Player
    var player: AVAudioPlayer!

    // Connected to the 3 buttons
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // Invalidate timer
        timer.invalidate()
        
        // Soft, Medium or Hard
        let hardness = sender.currentTitle!
        
        // Reset progress bar, seconds passed and titleLabel
        eggProgressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = "\(hardness) egg in progress..."

        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        
        if secondsPassed < totalTime {
            secondsPassed += 1
            eggProgressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            // Ring Alarm
            playSound(soundName: "alarm_sound")
        }
    }

    // Function to play sound
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}




