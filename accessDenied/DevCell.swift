//
//  DevCell.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 03/02/21.
//

import UIKit
import WebKit
import SafariServices

protocol CellDelegate: class {
    func CellBtnTapped(tag: Int)
}

protocol CellDelegate2: class {
    func GitBtnTapped(tag: Int)
}

class DevCell: UITableViewCell {
    
    
    
    @IBOutlet weak var dpImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var skillImage: UIImageView!
    
    @IBOutlet weak var skillLabel: UILabel!
    
    @IBOutlet weak var linkedInBtn: UIButton!
    weak var delegate: CellDelegate?
    
        
    @IBAction func linkedInBtnTapped(_ sender: UIButton) {
        delegate?.CellBtnTapped(tag: sender.tag)
    }
    
    
    @IBOutlet weak var gitBtn: UIButton!
    weak var delegate2:CellDelegate2?
    
    
    
    @IBAction func gitBtnTapped(_ sender: UIButton) {
        delegate2?.GitBtnTapped(tag: sender.tag)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
