//
//  ViewController.swift
//  Scribe
//
//  Created by robot on 4/29/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import Speech
import AVFoundation
import CoreMIDI

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!;
    @IBOutlet weak var transcriptionTextField: UITextView!;
    
    @IBOutlet weak var recordButton: UIButton!;
    @IBOutlet weak var playButton: UIButton!;
    
    var audioRecorder: AVAudioRecorder!;
    var audioPlayer: AVAudioPlayer!;
    var recordingSession: AVAudioSession!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true;
        self.setupView();
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop();
        recordButton.isEnabled = true
        playButton.setTitle("Play", for: .normal)
        activitySpinner.stopAnimating();
        activitySpinner.isHidden = true;
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Error while recording audio \(error!.localizedDescription)")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Error while playing audio \(error!.localizedDescription)")
    }
    
    
    //Reading the pre-recorded audio file
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authstatus in
            if authstatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = self.getFileURL() as URL? {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound;
                        self.audioPlayer.delegate = self;
                        sound.play();
                    } catch {
                        print("Error!");
                    }
                    
                    let recognizer = SFSpeechRecognizer();
                    let request = SFSpeechURLRecognitionRequest(url: path);
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error \(error)");
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString;
                        }
                    }
                }
            }
        }
    }
    
    func loadRecordingUI() {
        recordButton.isEnabled = true
        playButton.isEnabled = false
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.addTarget(self, action: #selector(recordAudioButtonTapped), for: .touchUpInside)
        view.addSubview(recordButton)
    }
    
    func setupView() {
           recordingSession = AVAudioSession.sharedInstance()
           
           do {
               try recordingSession.setCategory(.playAndRecord, mode: .default)
               try recordingSession.setActive(true)
               recordingSession.requestRecordPermission() { [unowned self] allowed in
                   DispatchQueue.main.async {
                       if allowed {
                           self.loadRecordingUI()
                       } else {
                           // failed to record
                       }
                   }
               }
           } catch {
               // failed to record
           }
       }
    
    func startRecording() {
        let audioFilename = getFileURL()
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            recordButton.setTitle("Tap to Stop", for: .normal)
            playButton.isEnabled = false
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
        
        playButton.isEnabled = true
        recordButton.isEnabled = true
    }
    
    func preparePlayer() {
        var error: NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileURL() as URL)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        
        if let err = error {
            print("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 10.0
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getFileURL() -> URL {
        let path = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        return path as URL
    }
    
    
    @IBAction func playBtnPressed(_ sender: Any) {
        activitySpinner.isHidden = false;
        activitySpinner.startAnimating();
        requestSpeechAuth();
    }
    
    @IBAction func recordAudioButtonTapped(_ sender: UIButton) {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    @IBAction func playAudioButtonTapped(_ sender: UIButton) {
        if (sender.titleLabel?.text == "Play"){
                   recordButton.isEnabled = false
                   sender.setTitle("Stop", for: .normal)
                   preparePlayer()
                   audioPlayer.play()
               } else {
                   audioPlayer.stop()
                   sender.setTitle("Play", for: .normal)
               }
    }
    
    
    
}

