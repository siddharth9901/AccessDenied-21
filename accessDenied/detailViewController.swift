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
        let imageName = "65-1.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        

        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
