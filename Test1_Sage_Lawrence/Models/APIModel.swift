//
//  APIModel.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-22.
//

import Foundation

enum Section{
    case main
}

//These show all movies. NOT the CoreData ones.
struct ActionFlicks: Codable {
    var results: [ActionFlick]
}

struct ActionFlick: Codable, Hashable {
    var id: String
    var director: String
    var movieTitle: String
    var preview: String?
    var albumImage: String?
    var genre: String
    var fanClubs: [FanClub]
}

//Array nested in class
struct FanClub: Codable, Hashable {
    var id: Int
    var address: String
    var manager: String
    var latitude: Double
    var longitude: Double
}
