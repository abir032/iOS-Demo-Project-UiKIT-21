//
//  MusicPlaylist.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 30/12/22.
//

import UIKit

class MusicPlaylist: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var singerName: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var musicProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 20
        musicProfile.layer.cornerRadius = 30
        musicProfile.image = UIImage(named: "numb")
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
