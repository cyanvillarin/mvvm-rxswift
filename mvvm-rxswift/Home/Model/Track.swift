//
//  Track.swift
//  mvvm-rxswift
//
//  Created by CYAN on 9/26/20.
//  Copyright © 2020 Cyan Villarin. All rights reserved.
//

import Foundation

struct Track: Codable {
   let id, name, trackArtWork, trackAlbum: String
   let artist: String
   
   enum CodingKeys: String, CodingKey {
      case id, name
      case trackArtWork = "track_art_work"
      case trackAlbum = "track_album"
      case artist
   }
}

extension Track {
   init?(data: Data) {
      guard let info = try? JSONDecoder().decode(Track.self, from: data) else {
         return nil
      }
      self = info
   }
}
