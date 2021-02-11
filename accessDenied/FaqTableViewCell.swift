//
//  FaqTableViewCell.swift
//  accessDenied
//
//  Created by riddhi gupta on 11/02/21.
//

import UIKit

class FaqTableViewCell: UITableViewCell {

 
    @IBOutlet weak var buttontapped: UIButton!
    @IBOutlet weak var question: UILabel!
    
    var sectionIsExpanded = String()  {
        didSet {
            UIView.animate(withDuration: 0.5) {
                if self.sectionIsExpanded == "True"{
                    self.buttontapped.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
                    
                } else {
                    
                    self.buttontapped.imageView?.transform = CGAffineTransform.identity
                }
            }
        }
    }
    var tapCallback: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func buttontapped(_ sender: Any) {
     //   sectionIsExpanded = !sectionIsExpanded
        tapCallback?()

        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
