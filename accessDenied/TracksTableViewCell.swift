//
//  TracksTableViewCell.swift
//  accessDenied
//
//  Created by riddhi gupta on 12/02/21.
//

import UIKit

class TracksTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var assest: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
