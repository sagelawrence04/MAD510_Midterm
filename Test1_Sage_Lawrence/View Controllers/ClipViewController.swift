//
//  ClipViewController.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-21.
//

import UIKit
import AVKit

//Shows the movie clip from the InformationVC
class ClipViewController: AVPlayerViewController {

    //MARK: Properties
    var actionFlick: ActionFlick? //allows me to access the passed value to play the video

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let actionFlick = actionFlick  else {return}
        
        if let previewString = actionFlick.preview,
           let previewURL = URL(string: previewString) {
            // Successfully converted to URL
            print("Preview URL: \(previewURL)")
            player = AVPlayer(url: previewURL)
            player?.play()
            
        } else {
            // Handle the case where the string couldn't be converted to a URL
            print("Invalid URL string")
        }
    }
}
