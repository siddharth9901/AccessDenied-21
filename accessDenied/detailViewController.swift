//
//  ViewController.swift
//  accessDenied
//
//  Created by riddhi gupta on 10/02/21.


import UIKit

class detailViewController: UIViewController {

    var detailText: String?
    var image: UIImage?
    
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var details: UITextView!
    
    
    override func viewDidLoad() {
        headerImage.image = image
        details.text = detailText
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
