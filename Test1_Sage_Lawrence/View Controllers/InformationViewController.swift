//
//  InformationViewController.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-20.
//

import UIKit

class InformationViewController: UIViewController {

    //MARK: Properties
    var coreDataStack: CoreDataStack!
    var actionFlick: ActionFlick? //allows me to access all saved data
    
    //MARK: Outlets
    //TODO: All the Labels
    
    //MARK: Actions
    //TODO: Watch Clip Btn, Add to Watchlist Btn
    
    //Add to Watchlist: Alert pops up
    /*
     Title: Add to watchlist?
     Text: Would you like to add \(movie name) by \(direction) to your weekend watchlist?
     Cancel | Add It!
     
     Confirm:
        Saves title, genre, and URL for the video
        Pop user back to the list of action  movies
     
     Cancel:
        Dismisses
     */
    
    //Watch Clip: Opens the Video URL and automatically plays it
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: TableView Delegate
    }
}

extension InformationViewController: UITableViewDelegate {
    //TODO: Holds address & presidents name
}
