//
//  ViewController.swift
//  ExampleAudioRecorder
//
//  Created by michal on 05/11/16.
//  Copyright © 2016 borama. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var isRecording = false;
    var isPlaying = false;
    let myRecorder = RecordAudio()
    let myPlayer = PlayAudio()
    var i = 0;
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
    var recordingName = "recordedVoice.wav"

    
    @IBOutlet weak var recButton: UIButton!
    
    @IBOutlet weak var micLabel: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playBtnAction() {
        if isPlaying {
            isPlaying = false
            myPlayer.stopAudio()
            playButton.setTitle("Play", for: UIControlState.normal)
        } else {
            playButton.setTitle("Stop", for: UIControlState.normal)
            recordingName = "recordedVoice_\(i).wav"
            let pathArray = [dirPath, recordingName]
            let filePath = NSURL.fileURL(withPathComponents: pathArray)
            myPlayer.setupAudio(url: filePath!)
//            myPlayer.playSound(pitch: 500)
            myPlayer.playSound(pitch: 200)
            isPlaying = true
            i += 1
        }
    }
    @IBAction func recBtnAction() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }
    
    func stopRecording() {
        isRecording = false
        recButton.setTitle("Record", for: UIControlState.normal)
        myRecorder.stopRecording()
    }

    func startRecording() {
        recordingName = "recordedVoice_\(i).wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath!)
        myRecorder.startRecording(url: filePath!)
        recButton.setTitle("Stop", for: UIControlState.normal)
        isRecording = true
        
    }
}

