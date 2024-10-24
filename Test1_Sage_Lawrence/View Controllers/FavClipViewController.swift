//
//  FavClipViewController.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-24.
//

import UIKit
import AVKit

//Displays the Favourited Clip
class FavClipViewController: AVPlayerViewController {
    
    var preview: Watchlist?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let preview = preview else {return}
        
        if let previewString = preview.videoURL,
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
