//
//  ViewController.swift
//  accessDenied
//
//  Created by riddhi gupta on 10/02/21.
//

import UIKit
import SDWebImage

class speakerMainTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var speakerImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        speakerImage.clipsToBounds = true
        speakerImage.layer.cornerRadius = speakerImage.frame.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
