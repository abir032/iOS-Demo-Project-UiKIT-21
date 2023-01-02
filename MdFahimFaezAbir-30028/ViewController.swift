//
//  ViewController.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 29/12/22.
//

import UIKit

protocol delegateProtocol{
    func updateData(minute: Int,sceond: Int,songName: String,singer: String,indexPath: IndexPath)
    func isSelected(selected: Bool)
}

class ViewController: UIViewController, delegateProtocol {
    
    @IBOutlet weak var controlPanel: UIView!
    @IBOutlet weak var musicDisk: UIImageView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var backWardButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var finishMinute: UILabel!
    @IBOutlet weak var finishSceond: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var singer: UILabel!
    var sceondCount = 0
    var minitueCount = 0
    var totalTime  = 0
    var finishTime = 0
    var currIndex = 0
    var flag = true
    let gif = UIImage.gifImageWithName("music-disc")
    var timer = Timer()
    var isSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlPanel.layer.cornerRadius = 30
        musicDisk.image = UIImage(named: "sc-disk")
        //musicDisk.image = gif
        songName.text = "Choose Song"
        singer.text = "UnKnown"
        pauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        progressBar.setProgress(0.0, animated: true)
    }
    
    func isSelected(selected: Bool) {
        isSelected = true
    }
    
    @IBAction func pauseButtonAction(_ sender: Any) {
        if flag  && isSelected{
            flag = false
            pauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            musicDisk.image = gif
            musicTimer()
        }else{
            flag = true
            pauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            timer.invalidate()
            musicDisk.image = UIImage(named: "sc-disk")
        }
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        
    }
    @IBAction func backWardButtonAction(_ sender: Any) {
        if isSelected{
            flag = false
            goBackward()
        }
    }
    @IBAction func forwardButtonAction(_ sender: Any) {
        if isSelected{
            flag = false
            goForward()
        }
    }
    @IBAction func restartButtonAction(_ sender: Any) {
        resetMusicPlayer()
    }
    
    
}

// MARK: - Forward & Backward
extension ViewController{
    func musicLoop(){
        flag = false
        self.pauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        self.musicDisk.image = gif
        goForward()
    }
    func goBackward(){
        if currIndex > 0 {
            sceondCount = 0
            minitueCount = 0
            totalTime = 0
            self.pauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            self.musicDisk.image = gif
            timer.invalidate()
            musicTimer()
            progressBar.setProgress(0.0, animated: true)
            currIndex -= 1
            finishMinute.text = String(MusicList.musicList[currIndex].minute)
            finishSceond.text = String(MusicList.musicList[currIndex].sceoned)
            self.songName.text =  MusicList.musicList[currIndex].musicName
            self.singer.text =  MusicList.musicList[currIndex].singer
            finishTime =  MusicList.musicList[currIndex].minute * 60 +  MusicList.musicList[currIndex].sceoned
            
        }
    }
    
    func goForward(){
        if currIndex < MusicList.musicList.count-1 {
            sceondCount = 0
            minitueCount = 0
            totalTime = 0
            timer.invalidate()
            musicTimer()
            progressBar.setProgress(0.0, animated: true)
            self.pauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            currIndex += 1
            finishMinute.text = String(MusicList.musicList[currIndex].minute)
            finishSceond.text = String(MusicList.musicList[currIndex].sceoned)
            self.songName.text =  MusicList.musicList[currIndex].musicName
            self.singer.text =  MusicList.musicList[currIndex].singer
            finishTime =  MusicList.musicList[currIndex].minute * 60 +  MusicList.musicList[currIndex].sceoned
        }
    }
    
    
}
// MARK: - Reset Music Player
extension ViewController{
    func resetMusicPlayer(){
        flag = true
        isSelected = false
        songName.text = "Choose Song"
        singer.text = "UnKnown"
        sceondCount = 0
        minitueCount = 0
        totalTime  = 0
        finishTime = 0
        currIndex = 0
        minuteLabel.text = "0"
        secondLabel.text = "0"
        finishMinute.text = "0"
        finishSceond.text = "0"
        progressBar.setProgress(0.0, animated: true)
        pauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        musicDisk.image = UIImage(named: "sc-disk")
        timer.invalidate()
    }
}

// MARK: - Prepare Segue

extension ViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.wayToSec{
            if let secView = segue.destination as? SecView {
                secView.delegate = self
            }
        }
    }
    func updateData(minute: Int, sceond: Int, songName: String, singer: String, indexPath: IndexPath) {
        sceondCount = 0
        minitueCount = 0
        totalTime = 0
        timer.invalidate()
        progressBar.setProgress(0.0, animated: true)
        finishMinute.text = String(minute)
        finishSceond.text = String(sceond)
        self.songName.text = songName
        self.singer.text = singer
        currIndex = indexPath.row
        finishTime = minute * 60 + sceond
        flag = false
        musicTimer()
        pauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        musicDisk.image = gif
        //musicTimer()
        
    }
}

//MARK: - Timer Section
extension ViewController{
    func musicTimer(){
        
        var counter  = totalTime
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){[weak self] timer in
            guard let self = self else {return}
            if counter > self.finishTime{
                
                self.totalTime = 0
                counter = 0
                self.totalTime = 0
                self.sceondCount = 0
                self.progressBar.setProgress(0.0, animated: true)
                self.pauseButton.setImage(UIImage(systemName: "play"), for: .normal)
                self.musicDisk.image = UIImage(named: "sc-disk")
                if self.currIndex != MusicList.musicList.count-1{
                    self.musicLoop()
                } else {
                    self.minuteLabel.text = "0"
                    self.secondLabel.text = "0"
                    self.pauseButton.setImage(UIImage(systemName: "play"), for: .normal)
                    self.musicDisk.image = UIImage(named: "sc-disk")
                    self.flag = true
                    timer.invalidate()
                    return
                }
            }
            self.progressBar.setProgress(Float(counter)/Float(self.finishTime), animated: true)
            self.secondLabel.text = String(self.sceondCount)
            if self.sceondCount == 60{
                self.sceondCount = 0
                self.minitueCount += 1
                self.minuteLabel.text = String(self.minitueCount)
            }
            self.minuteLabel.text = String(self.minitueCount)
            counter += 1
            self.totalTime += 1
            self.sceondCount += 1
        }
    }
}
