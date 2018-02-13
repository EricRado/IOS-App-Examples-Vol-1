//
//  ViewController.swift
//  HappyDays
//
//  Created by Eric Rado on 2/13/18.
//  Copyright © 2018 Eric Rado. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class ViewController: UIViewController {
    
    @IBOutlet weak var helpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func requestPermission(_ sender: UIButton) {
        requestPhotosPermissions()
    }
    
    func requestPhotosPermissions(){
        PHPhotoLibrary.requestAuthorization{ [unowned self]
            authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized{
                    self.requestRecordPermissions()
                }else{
                    self.helpLabel.text = "Photos permission was declined"
                }
            }
        }
    }
    
    func requestRecordPermissions(){
        AVAudioSession.sharedInstance().requestRecordPermission(){
            [unowned self] allowed in
            DispatchQueue.main.async {
                if allowed{
                    self.requestTranscribePermissions()
                }else{
                    self.helpLabel.text = "Recording permission was declined"
                }
            }
        }
    }
    
    func requestTranscribePermissions(){
        SFSpeechRecognizer.requestAuthorization{ [unowned self]
            authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized{
                    self.authorizationComplete()
                }else{
                    self.helpLabel.text = "Transcribe permission was declined"
                }
            }
        }
    }
  
    func authorizationComplete(){
        dismiss(animated: true)
    }

}

