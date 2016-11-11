//
//  RecordAudio.swift
//  ExampleAudioRecorder
//
//  Created by michal on 05/11/16.
//  Copyright © 2016 borama. All rights reserved.
//

import AVFoundation

public class RecordAudio {
        
    var audioRecorder: AVAudioRecorder!
    
    func startRecording(url: URL) {
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(url: url, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
}
