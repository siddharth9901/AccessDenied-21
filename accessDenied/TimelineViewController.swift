//
//  TimelineViewController.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 07/02/21.
//

import UIKit
import FirebaseDatabase
import SDWebImage
import SafariServices
import Toaster

class TimelineViewController: UIViewController {
    
    var activityIndicatorView: ActivityIndicatorView!
    
    
    
    @IBOutlet weak var sc: UISegmentedControl!
    
   
    //Firebase:<_____
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    //var postData = [[String]]()
    
   
    @IBOutlet weak var errorLabel: UILabel!
    

    var events: [event] = []
    //_______>
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    struct  event {
        let StartTime: String
        let EndTime: String
        let description: String // About the event
        let meetLink: String // Link of meeting
        let dp: String // Profile picture
        let status: Int
        let social: String
    }
    
    //var events: [event] = [event(time: "10:30 PM", description: "Hack Begins - 36 hours to go.",  meetLink: "", dp: UIImage(named: "sidDP")!)]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = "65-1.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TimelineCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
                
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
     
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.checkForInternetConnection() == true){
            errorLabel.isHidden = true
            startLoadData()
            if(sc.selectedSegmentIndex == 0){
                loadData(EventDate: "17")
            }else if(sc.selectedSegmentIndex == 1){
                loadData(EventDate: "18")
            }else if(sc.selectedSegmentIndex == 2){
                loadData(EventDate: "19")
            }else if(sc.selectedSegmentIndex == 2){
                loadData(EventDate: "20")
            }else if(sc.selectedSegmentIndex == 2){
                loadData(EventDate: "21")
            }
        }else{
            if(events.count == 0){
                events = []
                errorLabel.isHidden = false
            }
        }
        resetBadgeCount()
    }
    
    func resetBadgeCount() {

        // A. reset userDefaults badge counter to 0
        UserDefaults.standard.setValue(0, forKey: "accessDeniedBadgeCount")
        // B. reset this back to 0 too
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func startLoadData(){
        self.activityIndicatorView = ActivityIndicatorView(title: "Loading...", center: self.view.center)
            self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())

        activityIndicatorView.startAnimating()
    }
    
    
    func loadData(EventDate: String) {
        
        ref = Database.database().reference().child("Timeline").child(EventDate)
                ref?.observe(DataEventType.value, with: {
                    (snapshot) in
                    self.events = [ ]
                    self.activityIndicatorView.stopAnimating()
                    if(snapshot.childrenCount>0){
//                        self.timelineList.removeAll()
//
//
                        for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                        {
                            let cellObject = cellContents.value as? [String: AnyObject]
                            
//                            let cellName = cellObject?["name"]
//                            let cellTime = cellObject?["time"]
//                            let cellImage = cellObject?["image"]
//
                            let item = event(StartTime: cellObject?["StartTime"] as! String? ?? "", EndTime: cellObject?["EndTime"] as! String? ?? "",description: cellObject?["EventName"] as! String? ?? "", meetLink: cellObject?["Link"] as! String? ?? "", dp: cellObject?["SpeakerPhoto"] as! String? ?? "", status: cellObject?["Status"] as! Int? ?? 0, social: cellObject?["social"] as! String? ?? "")
                            self.events.append(item)
                            self.tableView.reloadData()
                        }
                      //  self.tableView.reloadData()
//
                        //Mark: - Offline functionalities
                        self.ref?.keepSynced(true)
                    }
                })
        
    }
    
    
   
    
   
    
  
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        
        
        
        if sender.selectedSegmentIndex == 0{
            
            if(self.checkForInternetConnection() == true){
                startLoadData()
                loadData(EventDate: "17")
            }
           
            
        }
         
        else if sender.selectedSegmentIndex == 1{
           
            if(self.checkForInternetConnection() == true){
                startLoadData()
                loadData(EventDate: "18")
            }
        }
        else if sender.selectedSegmentIndex == 2{
           
            if(self.checkForInternetConnection() == true){
                startLoadData()
                loadData(EventDate: "19")
            }
        }
        else if sender.selectedSegmentIndex == 3{
           
            if(self.checkForInternetConnection() == true){
                startLoadData()
                loadData(EventDate: "20")
            }
        }
        else{
           
            if(self.checkForInternetConnection() == true){
                startLoadData()
                loadData(EventDate: "21")
            }
        }
        
        
    }
    
    let cellSpacingHeight: CGFloat = 20
    
    
}

extension TimelineViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.events.count
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TimelineCell
        
        cell.time?.text = "\(events[indexPath.section].StartTime)"
        if(events[indexPath.section].EndTime.count > 0){
            cell.time?.text = (cell.time?.text)! + " - \(events[indexPath.section].EndTime)"
        }
        cell.descripLabel?.text = events[indexPath.section].description
        //cell.skillImage? =    events[indexPath.section].eventType
       // cell.dpImage?.image = events[indexPath.section].dp
        cell.layer.cornerRadius = 20
        cell.backgroundColor = UIColor.white
        
        cell.delegateT = self
        cell.playButtonOutlet.tag = indexPath.section
        cell.playButtonOutlet.setTitle("\(indexPath.section)", for: .normal)
        
        cell.delegateT2 = self
        cell.copyBtnOutlet.tag = indexPath.section
        cell.copyBtnOutlet.setTitle("\(indexPath.section)", for: .normal)
        
        cell.socialDelegate = self
        cell.dpSocial.tag = indexPath.section
        cell.dpSocial.setTitle("\(indexPath.section)", for: .normal)
        //Code for dev button
//        cell.delegate = self
//        cell.linkedInBtn.tag = indexPath.section
//        cell.linkedInBtn.setTitle("\(indexPath.section)", for: .normal)
//
//        cell.delegate2 = self
//        cell.gitBtn.tag = indexPath.section
//        cell.gitBtn.setTitle("\(indexPath.section)", for: .normal)
        cell.backgroundColor = Colors.faqCellBackground
        
        
        
        //Hiding profile image of speaker
        if events[indexPath.section].dp.count == 0{
            cell.dpImageView.isHidden = true
        } else {
            cell.dpImageView.isHidden = false
            cell.dpImageView.layer.cornerRadius = cell.dpImageView.frame.height/2
            cell.dpImageView?.sd_setImage(with: URL(string: events[indexPath.section].dp))
        }
        
        if events[indexPath.section].status == 1{
                cell.layer.borderWidth = 3
                cell.layer.borderColor = Colors.faqText.cgColor
            } else {
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.clear.cgColor
            }
        
        //Hiding the buttons
        let meet = events[indexPath.section].meetLink.count
        if meet == 0{
            cell.copyBtnOutlet.setImage(nil, for: .normal)
            cell.copyBtnOutlet.isHidden = true
            
            cell.playButtonOutlet.setImage(nil, for: .normal)
            cell.playButtonOutlet.isHidden = true
        } else{
            cell.playButtonOutlet.isHidden = false
            cell.playButtonOutlet.setImage(UIImage(named: "Icon ionic-md-play-circle"), for: .normal)
            
            cell.copyBtnOutlet.isHidden = false
            cell.copyBtnOutlet.setImage(UIImage(systemName:  "doc.on.clipboard.fill"), for: .normal)
        }
        return cell
    }
}


extension TimelineViewController: CellDelegateT{
    func playBtnTapped(tag: Int) {
        // Adding webView
        let vc = SFSafariViewController(url: URL(string: events[tag].meetLink)!)
        present(vc, animated: true)
    }
}

extension TimelineViewController: CellDelegateT2{
    func copyBtnTapped(tag: Int) {
        let MeetLink = events[tag].meetLink
        UIPasteboard.general.string = MeetLink
        let toast = Toast(text: "Meeting Link copied")
        toast.show()
        ToastView.appearance().backgroundColor = UIColor.gray
        ToastView.appearance().textColor = Colors.faqText
        ToastView.appearance().bottomOffsetPortrait = self.view.frame.height/2
        ToastView.appearance().font = UIFont(name: "System Medium", size: 20)
    }
}

extension TimelineViewController: CellDelegateSocial{
    func socialBtnTapped(tag: Int) {
        if(events[tag].social != nil && events[tag].social.count > 0){
            let vc = SFSafariViewController(url: URL(string: events[tag].social)!)
            present(vc, animated: true)
        }
    }
}

