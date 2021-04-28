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
  
    @IBOutlet weak var titleSponsor: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var SponsorsTCV: UICollectionView!
    @IBOutlet weak var SponsorsPCV: UICollectionView!
    @IBOutlet weak var SponsorsACV: UICollectionView!
    @IBOutlet weak var SponsorsECV: UICollectionView!
    
    @IBOutlet weak var SponsorsMCV: UICollectionView!
    
    
    @IBOutlet weak var SponsorsCCV: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var poweredByLabel: UILabel!
    @IBOutlet weak var associateLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var commLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
    
    var sponsors : [SponsorModel] = []
    var sponsorsT: [SponsorModel] = []
    var sponsorsP: [SponsorModel] = [ ]
    var sponsorsA: [SponsorModel] = [ ]
    var sponsorsE: [SponsorModel] = [ ]
    var sponsorsM:  [SponsorModel] = [ ]
    var sponsorsC:  [SponsorModel] = [ ]
    
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = "65-1.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        self.SponsorsTCV.reloadData()
        SponsorsTCV.delegate = self
        SponsorsTCV.dataSource = self
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.checkForInternetConnection() == true){
            self.activityIndicatorView = ActivityIndicatorView(title: "Loading...", center: self.view.center)
                self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())

            activityIndicatorView.startAnimating()
            loadData(SponCat: "Title")
            loadData(SponCat: "PoweredBy")
            loadData(SponCat: "Associate")
            loadData(SponCat: "Education")
            loadData(SponCat: "Media")
            loadData(SponCat: "Community")
            scrollView.isScrollEnabled = true
            associateLabel.text = "Associate Sponsors"
        }else{
//            poweredByLabel.isHidden = true
            associateLabel.text = "Data Unavailable. Please check your Internet Connection."
            scrollView.isScrollEnabled = false
            titleLabel.isHidden = true
            poweredByLabel.isHidden = true
            educationLabel.isHidden = true
            commLabel.isHidden = true
            mediaLabel.isHidden = true
        }
    }
    
    func loadData(SponCat: String) {
        
        switch SponCat {
        case "Title": do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsT = [ ]
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsT.append(item)
                                        self.SponsorsTCV.reloadData()
                                    }
                                    self.SponsorsTCV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
//            if(sponsorsP.count == 0){
//                poweredByLabel.isHidden = true
//            }else{
//                poweredByLabel.isHidden = false
//            }
        }
        case "PoweredBy": do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsP = [ ]
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsP.append(item)
                                        self.SponsorsPCV.reloadData()
                                    }
                                    self.SponsorsPCV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
//            if(sponsorsP.count == 0){
//                poweredByLabel.isHidden = true
//            }else{
//                poweredByLabel.isHidden = false
//            }
        }
        
        case "Associate": do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsA = [ ]
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsA.append(item)
                                        self.SponsorsACV.reloadData()
                                    }
                                    self.SponsorsACV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
//            if(sponsorsA.count==0){
//                associateLabel.isHidden = true
//            }else{
//                associateLabel.isHidden = false
//            }
        }
        
        case "Education": do{
            ref = Database.database().reference().child("Sponsors").child(SponCat)
                        ref?.observe(DataEventType.value, with: {
                            (snapshot) in
                            self.sponsorsE = [ ]
                            self.activityIndicatorView.stopAnimating()
                            if(snapshot.childrenCount>0){
                                    for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                                    {
                                        let cellObject = cellContents.value as? [String: AnyObject]
                    
                                        let item = SponsorModel(Logo: cellObject?["Logo"] as! String? ?? "Failed to load image", Weblink: cellObject?["Weblink"] as! String? ?? "Failed to load Weblink")
                                      
                                        self.sponsorsE.append(item)
                                        self.SponsorsECV.reloadData()
                                    }
                                    self.SponsorsECV.reloadData()
                                    //Mark: - Offline functionalities
                                    self.ref?.keepSynced(true)
                            }
                        })
//            if(sponsorsE.count == 0){
//                educationLabel.isHidden = true
//            }else{
//                educationLabel.isHidden = false
//            }
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
//            if(sponsorsM.count == 0){
//                mediaLabel.isHidden = true
//            }else{
//                mediaLabel.isHidden = false
//            }
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
//            print(sponsorsC.count)
//            if(sponsorsC.count == 0){
//                commLabel.isHidden = true
//            }else{
//                commLabel.isHidden = false
//            }
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
        var size = CGSize(width: 140, height: 140)
        if(collectionView == SponsorsTCV){
            print("\n\n\n\nTitle\n\n\n")
            size = CGSize(width: 290, height: 140)
        }
        print(size);
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var len: Int
        switch collectionView{
        case SponsorsTCV:
            len = sponsorsT.count
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
        
        if collectionView == SponsorsTCV{
        cell.sponsorImage?.sd_setImage(with: URL(string: sponsorsT[indexPath.row].Logo))
        }
        else if collectionView == SponsorsPCV{
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
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == SponsorsTCV{
            let vc = SFSafariViewController(url: URL(string: sponsorsT[indexPath.row].Weblink)!)
            present(vc, animated: true)
        }
        else if collectionView == SponsorsPCV{
            let vc = SFSafariViewController(url: URL(string: sponsorsP[indexPath.row].Weblink)!)
            present(vc, animated: true)
        }
        else if collectionView == SponsorsACV{
            if(sponsorsA[indexPath.row].Weblink != ""){
                let vc = SFSafariViewController(url: URL(string: sponsorsA[indexPath.row].Weblink)!)
                    present(vc, animated: true)
            }
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
