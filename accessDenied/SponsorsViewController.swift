//
//  SponsorsViewController.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 11/02/21.
//

import UIKit
import Firebase
import SDWebImage
import SafariServices

struct SponsorModel{
    var Logo: String
    var Weblink: String
}



class SponsorsViewController: UIViewController {
    var activityIndicatorView: ActivityIndicatorView!
  
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var SponsorsPCV: UICollectionView!
    @IBOutlet weak var SponsorsACV: UICollectionView!
    @IBOutlet weak var SponsorsECV: UICollectionView!
    
    @IBOutlet weak var SponsorsMCV: UICollectionView!
    
    
    @IBOutlet weak var SponsorsCCV: UICollectionView!
    
    @IBOutlet weak var ourSponsorslabel: UILabel!
    
    
    var sponsors : [SponsorModel] = []
    
    var sponsorsP: [SponsorModel] = [ ]
    var sponsorsA: [SponsorModel] = [ ]
    var sponsorsE: [SponsorModel] = [ ]
    var sponsorsM:  [SponsorModel] = [ ]
    var sponsorsC:  [SponsorModel] = [ ]
    
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ourSponsorslabel.layer.cornerRadius = 10
        ourSponsorslabel.layer.masksToBounds = true
        let imageName = "65-1.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        if(self.checkForInternetConnection() == true){
            self.activityIndicatorView = ActivityIndicatorView(title: "Loading...", center: self.view.center)
                self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())

            activityIndicatorView.startAnimating()
            loadData(SponCat: "PoweredBy")
            loadData(SponCat: "Associate")
            loadData(SponCat: "Education")
            loadData(SponCat: "Media")
            loadData(SponCat: "Community")
        }
        
        self.SponsorsPCV.reloadData()
        SponsorsPCV.delegate = self
        SponsorsPCV.dataSource = self
        
        self.SponsorsACV.reloadData()
        SponsorsACV.delegate = self
        SponsorsACV.dataSource = self
        
        self.SponsorsECV.reloadData()
        SponsorsECV.delegate = self
        SponsorsECV.dataSource = self
        
        self.SponsorsMCV.reloadData()
        SponsorsMCV.delegate = self
        SponsorsMCV.dataSource = self
        
        self.SponsorsCCV.reloadData()
        SponsorsCCV.delegate = self
        SponsorsCCV.dataSource = self
    }
    
    
    func loadData(SponCat: String) {
        
        switch SponCat {
        case "PoweredBy": do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsP = [ ]
                            //print(snapshot)
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsP.append(item)
                                        self.SponsorsPCV.reloadData()
                                    }
                                    //print(self.sponsors)
                                    self.SponsorsPCV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
        }
        
        case "Associate": do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsA = [ ]
                            //print(snapshot)
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsA.append(item)
                                        self.SponsorsACV.reloadData()
                                    }
                                    //print(self.sponsors)
                                    self.SponsorsACV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
        }
        
        case "Education": do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsE = [ ]
                            //print(snapshot)
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsE.append(item)
                                        self.SponsorsECV.reloadData()
                                    }
                                    //print(self.sponsors)
                                    self.SponsorsECV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
        }
        
        case "Media": do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsM = [ ]
                            //print(snapshot)
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsM.append(item)
                                        self.SponsorsMCV.reloadData()
                                    }
                                    //print(self.sponsors)
                                    self.SponsorsMCV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
        }
        
        case "Community": do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsC = [ ]
                            //print(snapshot)
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsC.append(item)
                                        self.SponsorsCCV.reloadData()
                                    }
                                    //print(self.sponsors)
                                    self.SponsorsCCV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
        }
        
        default: do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsC = [ ]
                            //print(snapshot)
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsC.append(item)
                                        self.SponsorsCCV.reloadData()
                                    }
                                    //print(self.sponsors)
                                    self.SponsorsCCV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
        }
            
        }
        
      
        }
    // End of view controller class
}


extension SponsorsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 140, height: 140)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var len: Int
        switch collectionView{
        case SponsorsPCV:
            len = sponsorsP.count
            
        case SponsorsACV:
            len = sponsorsA.count
            //print(len) // Working
        
        case SponsorsECV:
            len = sponsorsE.count
            
        case SponsorsMCV:
            len = sponsorsM.count
        case SponsorsCCV:
            len = sponsorsC.count
           // print(len)
            
        default:
            len = 0
        }
        return  len
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Title", for: indexPath) as! sponsorsCollectionViewCell
        
        if collectionView == SponsorsPCV{
        cell.sponsorImage?.sd_setImage(with: URL(string: sponsorsP[indexPath.row].Logo))
        }
        else if collectionView == SponsorsACV {
            cell.sponsorImage?.sd_setImage(with: URL(string: sponsorsA[indexPath.row].Logo))
        }
        else if collectionView == SponsorsECV {
            cell.sponsorImage?.sd_setImage(with: URL(string: sponsorsE[indexPath.row].Logo))
        }
        else if collectionView == SponsorsMCV {
            cell.sponsorImage?.sd_setImage(with: URL(string: sponsorsM[indexPath.row].Logo))
        }
        else if collectionView == SponsorsCCV {
            cell.sponsorImage?.sd_setImage(with: URL(string: sponsorsC[indexPath.row].Logo))
        }
        cell.sponsorImage.layer.cornerRadius = 20
        cell.sponsorImage.clipsToBounds = true
       // print(sponsors)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if collectionView == SponsorsPCV{
       let vc = SFSafariViewController(url: URL(string: sponsorsP[indexPath.row].Weblink)!)
            present(vc, animated: true)
        }
        else if collectionView == SponsorsACV{
            let vc = SFSafariViewController(url: URL(string: sponsorsA[indexPath.row].Weblink)!)
                 present(vc, animated: true)
        }
        else if collectionView == SponsorsECV{
            let vc = SFSafariViewController(url: URL(string: sponsorsE[indexPath.row].Weblink)!)
                 present(vc, animated: true)
        }
        else if collectionView == SponsorsMCV{
            let vc = SFSafariViewController(url: URL(string: sponsorsM[indexPath.row].Weblink)!)
                 present(vc, animated: true)
        }
        else if collectionView == SponsorsCCV{
            let vc = SFSafariViewController(url: URL(string: sponsorsC[indexPath.row].Weblink)!)
                 present(vc, animated: true)
        }
        //self.website(link: sponsors[indexPath.row].Weblink)
    }
    
}
