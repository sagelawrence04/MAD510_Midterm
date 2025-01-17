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
    var actionFlick: ActionFlick? //allows me to access the passed value
    var fanClubs: [FanClub]?
    var watchlist = [Watchlist]()
    
    //MARK: Outlets
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var movie: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Actions
    //Adds the movie to the watchlist Core Data Model
    @IBAction func addToWatchlist(_ sender: UIButton) {
        guard let actionFlick = actionFlick  else { return }

        let alert = UIAlertController(title: "Add to Watchlist", message: "Would you like to add \(actionFlick.movieTitle) by \(actionFlick.director) to your weekend watchlist?", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Add it!", style: .default) { [unowned self] _ in
            self.addFlick(movie: actionFlick)
            navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    //Method to help with adding movie to Core Data
    func addFlick(movie: ActionFlick){
        let newMovie = Watchlist(context: coreDataStack.managedContext)
        guard let actionFlick = actionFlick  else { return }
        newMovie.director = actionFlick.director
        newMovie.movieTitle = actionFlick.movieTitle
        newMovie.genre = actionFlick.genre
        
        guard let moviePreview = actionFlick.preview else { return }
        newMovie.videoURL = moviePreview
        
        watchlist.append(newMovie)
        
        do {
            try coreDataStack.managedContext.save()
            print("Success!")
        } catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Unwrapping actionFlick
        guard let actionFlick = actionFlick  else { return }
        
        //Setting labels
        director.text = actionFlick.director
        movie.text = actionFlick.movieTitle
        genre.text = actionFlick.genre
        
        //Loads the fanClubs
        createSnapshot()
    }
    
    //MARK: - Tableview Diffable Datasource
    lazy var tableDataSource = UITableViewDiffableDataSource<Section, FanClub>(tableView: tableView) { tableView, indexPath, fanClub in
        let cell = tableView.dequeueReusableCell(withIdentifier: "fanClubCell", for: indexPath)
        cell.textLabel?.text = fanClub.manager
        cell.detailTextLabel?.text = fanClub.address
        return cell
    }
    
    //MARK: Create Snapshot for Tableview
    func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FanClub>()
        snapshot.appendSections([.main])
        snapshot.appendItems(actionFlick!.fanClubs)
        tableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    //The segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //This plays the video
        if segue.identifier == "playClip" {
            let destinationVC = segue.destination as! ClipViewController
            destinationVC.actionFlick = actionFlick
        }
        
        //This opens the map
        if segue.identifier == "openMap" {
            guard let index = tableView.indexPathForSelectedRow, let itemToPass = tableDataSource.itemIdentifier(for: index) else { return }
            let destinationVC = segue.destination as! MapViewController
            destinationVC.fanClub = itemToPass
        }
    }
}
