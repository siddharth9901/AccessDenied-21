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
    @IBOutlet weak var buttonTapped: UIButton!
    
    
    var sectionIsExpanded = String()  {
        didSet {
            UIView.animate(withDuration: 0.5) {
                if self.sectionIsExpanded == "True"{
                    self.buttonTapped.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
                    
                } else {
                    
                    self.buttonTapped.imageView?.transform = CGAffineTransform.identity
                }
            }
        }
    }
    var tapCallback: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        speakerImage.clipsToBounds = true
        speakerImage.layer.cornerRadius = speakerImage.frame.height/2
        // Initialization code
    }


    @IBAction func buttonTapped(_ sender: Any) {
        print("triggered")
        tapCallback?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
