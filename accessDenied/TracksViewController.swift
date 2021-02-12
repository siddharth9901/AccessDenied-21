//
//  TracksViewController.swift
//  accessDenied
//
//  Created by riddhi gupta on 12/02/21.
//

import UIKit

class TracksViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    
    
    var imageArray = [#imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "3"),#imageLiteral(resourceName: "7"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "5"),#imageLiteral(resourceName: "6")]
    var trackArray = [ "Women in Tech" , "Robotics and IOT" ,"HealthTech" , "Blockchain and Cryptocurrency", "Open Innovation" , "Education"]

    
    @IBOutlet weak var tracksTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = "65-1.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        tracksTV.delegate = self
        tracksTV.dataSource = self
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return imageArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TracksTableViewCell
        
        cell.title.text = trackArray[indexPath.row]
        cell.assest.image = imageArray[indexPath.row]
        return cell
        
    }

}
