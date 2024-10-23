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

struct FanClub: Codable, Hashable {
    var id: Int
    var address: String
    var manager: String
    var latitude: Double
    var longitude: Double
}

/*
 "id": "270835427",
       "director": "John McTiernan",
       "movieTitle": "Last Action Hero",
       "preview": "https://video-ssl.itunes.apple.com/itunes-assets/Video128/v4/2b/3c/42/2b3c426d-2cc3-0dd8-baee-fb30de9a33af/mzvf_8512664564344529101.640x352.h264lc.U.p.m4v",
       "numTracks": "5",
       "genre": "Action & Adventure",
       "trackExplicitness": "notExplicit",
       "albumImage": "https://is1-ssl.mzstatic.com/image/thumb/Music/ae/5f/68/mzi.midrcudh.jpg/100x100bb.jpg",
       "fanClubs": [
         {
           "address": "42 Thompson Lane, Windsor, Ontario",
           "longitude": 47.7489727,
           "id": 8,
           "manager": "Amii Batthew",
           "latitude": 45.5787215
         }
       ]
 */
