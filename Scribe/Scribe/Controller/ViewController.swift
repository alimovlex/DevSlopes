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
    
    var audioRecorder: AVAudioRecorder!;
    var audioPlayer: AVAudioPlayer!;
    var recordingSession: AVAudioSession!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true;
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop();
        activitySpinner.stopAnimating();
        activitySpinner.isHidden = true;
    }
    
    //Reading the pre-recorded audio file
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authstatus in
            if authstatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
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
    
    
    @IBAction func playBtnPressed(_ sender: Any) {
        activitySpinner.isHidden = false;
        activitySpinner.startAnimating();
        requestSpeechAuth();
    }
    
}

