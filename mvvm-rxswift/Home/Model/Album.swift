//
//  Album.swift
//  mvvm-rxswift
//
//  Created by CYAN on 9/26/20.
//  Copyright © 2020 Cyan Villarin. All rights reserved.
//

import Foundation

struct Album: Codable {
   let id, name, albumArtWork, artist: String
   
   enum CodingKeys: String, CodingKey {
      case id, name
      case albumArtWork = "album_art_work"
      case artist
   }
}

extension Album {
   init?(data: Data) {
      guard let info = try? JSONDecoder().decode(Album.self, from: data) else {
         return nil
      }
      self = info
   }
}
