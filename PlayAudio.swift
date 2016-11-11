//
//  PlayAudio.swift
//  ExampleAudioRecorder
//
//  Created by michal on 05/11/16.
//  Copyright © 2016 borama. All rights reserved.
//

import AVFoundation

public class PlayAudio {
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    func setupAudio(url: URL) {
        do {
            audioFile = try AVAudioFile(forReading: url as URL)
        } catch {
            print("error setting file")
        }
            }
    
    func playSound(rate: Float? = nil, pitch: Float? = nil) {
        
        // initialize audio engine components
        audioEngine = AVAudioEngine()
        
        // node for playing audio
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        // node for pitch
        let changeRatePitchNode = AVAudioUnitTimePitch()
        if let pitch = pitch {
            changeRatePitchNode.pitch = pitch
        }
        
        if let rate = rate {
            changeRatePitchNode.rate = rate
        }

        audioEngine.attach(changeRatePitchNode)
        
        /*
 the way you attach nodes is:
 Input - Node1 - Node2 - Output:
 aE.connect(Input, to: Node1, format:format)
 aE.connect(Node1, to: Node2, format:format)
 ae.connect(Node2, to: Output, format:format)
 
        audioEngine.connect(audioPlayerNode, to: changeRatePitchNode, format: audioFile.processingFormat)
        audioEngine.connect(changeRatePitchNode,to: audioEngine.outputNode, format: audioFile.processingFormat )
 */
        
        // attach audio input , node and output:
        connectAudioNodes(audioPlayerNode, changeRatePitchNode, audioEngine.outputNode)
        
        audioPlayerNode.stop()
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
            audioPlayerNode.play()
        } catch {
            print("can't play audio")
        }
    }
    
    func stopAudio() {
        if let audioPlayerNode = audioPlayerNode {
            audioPlayerNode.stop()
        }
        if let audioEngine = audioEngine {
            audioEngine.stop()
            audioEngine.reset()
        }
    }
    
    func connectAudioNodes(_ nodes: AVAudioNode...) {
        
        for x in 0..<nodes.count-1 {
            print(nodes[x])
            print(nodes[x+1])
            print("asdfasdfasdfasdfasdf")
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
    }
    
}
