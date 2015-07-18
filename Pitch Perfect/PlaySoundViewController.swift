//
//  PlaySoundViewController.swift
//  
//
//  Created by BenLacroix on 18/07/2015.
//
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var alertSound:NSURL = NSURL()
    
    var audioEngine: AVAudioEngine!
    var recordAudio:RecordAudio!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alertSound = self.recordAudio.filePathUrl
        self.audioEngine = AVAudioEngine()
        self.audioPlayer = AVAudioPlayer(contentsOfURL: self.alertSound, error: nil)
        self.audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recordAudio.filePathUrl, error: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        self.audioPlayer.stop()
        self.audioPlayer.rate = 0.2
        self.audioPlayer.prepareToPlay()
        self.audioPlayer.play()
    }

    @IBAction func playFast(sender: UIButton) {
        self.audioPlayer.stop()
        self.audioPlayer.rate = 2
        self.audioPlayer.prepareToPlay()
        self.audioPlayer.play()
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        self.playAudioWithPitch(1000)
    }
    @IBAction func playDarkVador(sender: UIButton) {
        self.playAudioWithPitch(-1000)
    }
    
    func playAudioWithPitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        self.audioPlayer.stop()
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
