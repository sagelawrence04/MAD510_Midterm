//
//  ActionFlicksViewController.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-20.
//

import UIKit

class ActionFlicksViewController: UIViewController {
    
    //MARK: Properties
    var actionFlicks = [ActionFlick]()
    lazy var coreDataStack = CoreDataStack(dataModelName: "Test1_Sage_Lawrence")
    
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: - Diffable Datasource
    lazy var collectionViewDataSource = UICollectionViewDiffableDataSource<Section, ActionFlick>(collectionView: collectionView) { collectionView, indexPath, actionFlick in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actionFlickCell", for: indexPath) as! CollectionViewCell
        if let posterPath = actionFlick.albumImage{
            self.fetchImage(forPath: posterPath, inCell: cell)
        }
        return cell
    }
    
    func createSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, ActionFlick>()
        snapshot.appendSections([.main])
        snapshot.appendItems(actionFlicks)
        collectionViewDataSource.apply(snapshot)
    }
    
    //MARK: - Fetch image
    func fetchImage(forPath path:String, inCell cell: CollectionViewCell){
        guard let imageURL = URL(string: path) else {
            print("Can't make this url: \(path)")
            return
        }
        let imageFetch = URLSession.shared.downloadTask(with: imageURL){ url, response, error in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                DispatchQueue.main.async { cell.image.image = image }
            }
        }
        imageFetch.resume()
    }
    
    //MARK: - Method to create URL
    func createURL(fromText text: String) -> URL?{
        guard let cleanURL = text.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) 
        else {
            fatalError("Can't make a url from: \(text)")
        }
        return URL(string: cleanURL)
    }
    
    //MARK: - Fetch Data
    func fetchActionFlicks(){
        
        let urlString = "https://dtakaki.scweb.ca/mad510/misc/testv2.json"
        guard let url = URL(string: urlString) else { return }
        
        let actionFlickTask = URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let dataError = error {
                print("Error fetching results: \(dataError.localizedDescription)")
            } else {
                guard let fetchedData = data else { return }
                do {
                    let jsonDecoder = JSONDecoder()
                    let downloadedResults = try jsonDecoder.decode(ActionFlicks.self, from: fetchedData)
                    self.actionFlicks = downloadedResults.results
                    print(self.actionFlicks)
                    DispatchQueue.main.async {
                        self.createSnapshot()
                    }
                } catch DecodingError.valueNotFound(let type, let context){
                    print("Error - value not found \(type): \(context)")
                } catch DecodingError.typeMismatch(let type, let context){
                    print("Error - types do not match \(type): \(context)")
                } catch DecodingError.keyNotFound(let key, let context){
                    print("Error - missing key \(key): \(context)")
                } catch{
                    print("Problem decoding: \(error.localizedDescription)")
                }
            }
        }
        actionFlickTask.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        
        fetchActionFlicks()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO: Tapping on a collectionViewCell opens up the InformationViewController
        //"openInformation"
        if segue.identifier == "openInformation" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let movie = collectionViewDataSource.itemIdentifier(for: indexPath)
            
            let destinationVC = segue.destination as! InformationViewController
            destinationVC.coreDataStack = coreDataStack
            destinationVC.actionFlick = movie
        }
    }
}

extension ActionFlicksViewController: UICollectionViewDelegate {
    //TODO: three cells evenly spaced with a small space between them with rounded corners
    }
