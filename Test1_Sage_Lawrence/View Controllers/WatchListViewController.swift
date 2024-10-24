//
//  WatchListViewController.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-20.
//

import UIKit
import CoreData

class WatchListViewController: UIViewController {

    //MARK: Properties
    lazy var coreDataStack = CoreDataStack(dataModelName: "Test1_Sage_Lawrence")
    var cellIdentifier = "favFlickCell"
    var watchlist = [Watchlist]()
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: TableView Datasource Methods
    lazy var tableDataSource = UITableViewDiffableDataSource<Section, Watchlist>(tableView: tableView) { tableView, indexPath, movie in
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        cell.textLabel?.text = movie.movieTitle
        cell.detailTextLabel?.text = movie.genre
        return cell
    }
    
    func createSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Watchlist>()
        snapshot.appendSections([.main])
        snapshot.appendItems(watchlist)
        snapshot.reloadItems(watchlist.sorted(by: {$0.movieTitle < $1.movieTitle}))
        tableDataSource.apply(snapshot)
    }
    
    //MARK: Fetch Films from Core Data
    func fetchFilms() {
        let fetchRequest: NSFetchRequest<Watchlist> = Watchlist.fetchRequest()

        do {
            watchlist = try coreDataStack.managedContext.fetch(fetchRequest)
            createSnapshot()
        } catch {
            print("Failed to fetch films: \(error.localizedDescription)")
        }
    }
    
    //MARK: Delete Item from Watchlist Watchlist
    func deleteFilm(_ film: Watchlist) {
        coreDataStack.managedContext.delete(film)
        do {
            try coreDataStack.managedContext.save()
            if let index = watchlist.firstIndex(of: film) {
                watchlist.remove(at: index)
                createSnapshot()
            }
        } catch {
            print("Failed to delete movie: \(error.localizedDescription)")
        }
    }
    
    //MARK: viewDid methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fetches the favourited films
        fetchFilms()
        
        //Reloads
        createSnapshot()
        
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Reloads
        createSnapshot()
    }
    

    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Shows Video Clip
        if segue.identifier == "favClip" {
            let destinationVC = segue.destination as! FavClipViewController
            guard let index = tableView.indexPathForSelectedRow, let itemToPass = tableDataSource.itemIdentifier(for: index) else { return }
            destinationVC.preview = itemToPass
        }
    }
}

//MARK: TableView Extension
extension WatchListViewController: UITableViewDelegate {
    
    //Functionality to delete movie
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] action, view, completionHandler in
            let movieToDelete = self.watchlist[indexPath.row]
            let alert = UIAlertController(title: "Delete Movie", message: "Are you sure you want to delete this movie from your watchlist?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.deleteFilm(movieToDelete)
                completionHandler(true)
            })
            self.present(alert, animated: true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}
