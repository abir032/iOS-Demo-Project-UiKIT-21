//
//  SecView.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 30/12/22.
//

import UIKit

class SecView: UIViewController {
    var delegate: delegateProtocol!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
   
}

// MARK: - Datasource
extension SecView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MusicList.musicList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.secViewCell, for: indexPath) as! MusicPlaylist
        cell.songName.text = MusicList.musicList[indexPath.row].musicName
        cell.singerName.text = MusicList.musicList[indexPath.row].singer
        cell.duration.text = String(MusicList.musicList[indexPath.row].minute) + " : " + String(MusicList.musicList[indexPath.row].sceoned)
        cell.musicProfile.image = UIImage(named: MusicList.musicList[indexPath.row].images)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
}

//MARK: - Delegate
extension SecView: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        setMusic(indexPath: indexPath)
        dismiss(animated: true)
    }
    func setMusic(indexPath: IndexPath){
        delegate.updateData(minute: MusicList.musicList[indexPath.row].minute, sceond: MusicList.musicList[indexPath.row].sceoned, songName: MusicList.musicList[indexPath.row].musicName, singer: MusicList.musicList[indexPath.row].singer, indexPath: indexPath)
        delegate.isSelected(selected: true)
    }
    
}
