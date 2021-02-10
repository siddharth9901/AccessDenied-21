//
//  TimelineCell.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 07/02/21.
//

import UIKit

protocol CellDelegateT: class {
    func playBtnTapped(tag: Int)
}

protocol CellDelegateT2: class {
    func copyBtnTapped(tag: Int)
}




class TimelineCell: UITableViewCell {
    
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    weak var delegateT: CellDelegateT?
    
    @IBAction func playBtnTapped(_ sender: UIButton) {
        delegateT?.playBtnTapped(tag: sender.tag)
    }
    
    
    @IBOutlet weak var copyBtnOutlet: UIButton!
    weak var delegateT2: CellDelegateT2?
    
    @IBAction func copyBtnTapped(_ sender: UIButton) {
        delegateT2?.copyBtnTapped(tag: sender.tag)
    }
    
    
    @IBOutlet weak var time: UILabel!
    

    @IBOutlet weak var descripLabel: UILabel!
    
    @IBOutlet weak var dpImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
