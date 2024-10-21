//
//  WatchListViewController.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-20.
//

import UIKit

class WatchListViewController: UIViewController {

    //MARK: Properties
    //TODO: CoreData
    
    //MARK: Outlets
    //TODO: TableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Shows Video Clip
    }
}

extension WatchListViewController: UITableViewDelegate {
    //TODO: Swiping left allows you to delete an item
    //TODO: Clicking on a movie opens up the video
}
