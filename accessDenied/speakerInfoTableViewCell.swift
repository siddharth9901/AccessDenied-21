//
//  ViewController.swift
//  accessDenied
//
//  Created by riddhi gupta on 10/02/21.
//

import UIKit
protocol CellDelegateR: class {
    func socialBtn(tag: Int)
}

class speakerInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var socialBtn: UIButton!
    weak var delegateR: CellDelegateR?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func socialBtnTapped(_ sender: Any) {
        delegateR?.socialBtn(tag: (sender as AnyObject).tag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
