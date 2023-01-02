//
//  MusicList.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 30/12/22.
//

import Foundation


struct MusicList{
    let musicName: String
    let singer: String
    let minute: Int
    let sceoned: Int
    let images: String
}

extension MusicList{
    static let musicList = [
        MusicList(musicName: "What I've Done", singer: "Linkin Park", minute: 3, sceoned: 30, images: "whatihavedone"),
        MusicList(musicName: "Numb", singer: "Linkin Park", minute: 3, sceoned: 20, images: "numb"),
        MusicList(musicName: "In the End", singer: "Linkin Park", minute: 3, sceoned: 40, images: "intheend"),
        MusicList(musicName: "New Divide", singer: "Linkin Park", minute: 3, sceoned: 35, images: "newdevide"),
        MusicList(musicName: "Faint", singer: "Linkin Park", minute: 4, sceoned: 30, images: "faint"),
        MusicList(musicName: "Somewhere I Belong", singer: "Linkin Park", minute: 4, sceoned: 0, images: "some"),
    ]
    
}
