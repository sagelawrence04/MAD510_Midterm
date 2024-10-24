//
//  Watchlist+CoreDataProperties.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-21.
//
//

import Foundation
import CoreData


extension Watchlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Watchlist> {
        return NSFetchRequest<Watchlist>(entityName: "Watchlist")
    }

    @NSManaged public var director: String
    @NSManaged public var movieTitle: String
    @NSManaged public var videoURL: String?
    @NSManaged public var genre: String

}

extension Watchlist : Identifiable {

}
