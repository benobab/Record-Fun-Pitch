//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by BenLacroix on 18/07/2015.
//  Copyright (c) 2015 BenLacroix. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSongViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    
    var audioRecorder:AVAudioRecorder!
    var recordAudio:RecordAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewWillAppear(animated: Bool) {
        self.stopRecordButton.hidden = true
        self.recordButton.enabled = true
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        self.recordAudio = RecordAudio()
        self.recordAudio.filePathUrl = recorder.url
        self.recordAudio.title = recorder.url.lastPathComponent
        self.performSegueWithIdentifier("play", sender: self)
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        self.recordingLabel.hidden = false
        self.stopRecordButton.hidden = false
        self.recordButton.enabled = false
        
        
        
        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        self.audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        self.audioRecorder.delegate = self
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.record()
        
    }
    
    @IBAction func stopRecord(sender: UIButton) {
        self.recordingLabel.hidden = true
        self.audioRecorder.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="play")
        {
            var destinationVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            destinationVC.recordAudio = self.recordAudio
            
        }
    }

}

