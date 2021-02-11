//
//  ViewController.swift
//  accessDenied
//
//  Created by riddhi gupta on 10/02/21.
//

import UIKit
import Firebase
import SDWebImage

struct infoTopics{
    var title: String
    var details: String
    var image: UIImage?
}
struct sponsorModel{
    var Logo: String
    var Name: String
    var Weblink: String
}

class infoViewController: UIViewController {
    
    var activityIndicatorView: ActivityIndicatorView!
    
    var infoText: String?
    var image: UIImage?
    
    var infoCells: [infoTopics] = [infoTopics(title: "About Access Denied", details: "Access Denied is a 36-hour hackathon organized by IETE-ISF for innovators across the country. It is an great opportunity to put your technical skills to use. Apply your textbook knowledge to real life ideas and stand a chance to win exclusive goodies, schwags, certificates and cash prizes upto Rs. 90,000. Mark your calendars for 19th to 21st March 2021.", image: UIImage(named: "Hackathon Logo")!),
                                   infoTopics(title: "About IETE", details: "The Institution of Electronics and Telecommunication Engineers (IETE) is India’s leading recognized professional society devoted to the advancement of Science and Technology of Electronics, Telecommunication and IT. Government of India has recognized IETE as a Scientific and Industrial Research Organization (SIRO) and also notified as an educational Institution of national eminence. The objectives of IETE focus on advancing electro-technology. The IETE conducts and partners technical meetings, conferences, symposia, and exhibitions all over India, publishes technical journals and providescontinuing education as well as career advancement opportunities to its members.", image: UIImage(named: "IETE WHITE")!),
                                   infoTopics(title: "Developer Info", details: " ", image: UIImage(named: "Hackathon Logo")!), infoTopics(title: "Contact Us", details: " ")]

    var sponsors : [sponsorModel] = []
    
    //var sponsors
    
    
    @IBOutlet weak var infoTV: UITableView!
    @IBOutlet weak var sponsorsCV: UICollectionView!
    
    var ref: DatabaseReference!
       var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        infoTV.delegate = self
        infoTV.dataSource = self
        infoTV.reloadData()
        if(self.checkForInternetConnection() == true){
            self.activityIndicatorView = ActivityIndicatorView(title: "Loading...", center: self.view.center)
                self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
            
            activityIndicatorView.startAnimating()
            loadData()
        }
        self.sponsorsCV.reloadData()
        sponsorsCV.delegate = self
        sponsorsCV.dataSource = self
        //sponsorsCV.delegate = self
        //sponsorsCV.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info"{
            let vc = segue.destination as! detailViewController
            vc.detailText = infoText
            vc.image = image
        }
    }
    
    func loadData() {
            ref = Database.database().reference().child("Sponsors")
                    ref?.observe(DataEventType.value, with: {
                        (snapshot) in
                        self.sponsors = [ ]
                        self.activityIndicatorView.stopAnimating()
                        if(snapshot.childrenCount>0){
                          
    //
    //
                            for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                            {
                                let cellObject = cellContents.value as? [String: AnyObject]
                                
    //
    //
                                let item = sponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Name: cellObject?["Name"] as! String? ?? "Failed to load Name" , Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                              
                                self.sponsors.append(item)
                                self.sponsorsCV.reloadData()
                            }
                         
                            //Mark: - Offline functionalities
                            self.ref?.keepSynced(true)
                        }
                    })
        }
    

    

}

extension infoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! infoOptionsTableViewCell
        cell.titleLabel.text = infoCells[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if infoCells[indexPath.row].title == "Developer Info"{
            self.performSegue(withIdentifier: "devInfo", sender: self)
        }
        else if infoCells[indexPath.row].title == "Contact Us"{
            self.performSegue(withIdentifier: "contactUs", sender: self)
        }
        else{
            self.infoText = infoCells[indexPath.row].details
            self.image = infoCells[indexPath.row].image
            self.performSegue(withIdentifier: "info", sender: self)
        }
    }
    
}

extension infoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 140, height: 140)
        return size
    }
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   return  sponsors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "title", for: indexPath) as! sponsorsCollectionViewCell
        cell.sponsorImage?.sd_setImage(with: URL(string: sponsors[indexPath.row].Logo))
        cell.sponsorImage.layer.cornerRadius = 20
        cell.sponsorImage.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.website(link: sponsors[indexPath.row].Weblink)
    }
    
    
}

//extension infoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 /*   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    */
    
//}
