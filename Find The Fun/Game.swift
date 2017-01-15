//
//  Game.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 12/01/17.
//  Copyright © 2017 Andrea. All rights reserved.
//

import Foundation


struct Game {
    let name: String?
    let genres: String?
    let firstReleaseDate: String?
    let thumbnailCoverURL: URL?
    let url: URL?
    
    init(name: String, genres: String, firstReleaseDate: String, thumbnailCoverURL: URL, url: URL) {
        self.name = name
        self.genres = genres
        self.firstReleaseDate = firstReleaseDate
        self.thumbnailCoverURL = thumbnailCoverURL
        self.url = url
    }
    

}
