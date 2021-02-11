//
//  ViewController.swift
//  accessDenied
//
//  Created by riddhi gupta on 10/02/21.
//

import UIKit
import FirebaseDatabase
import SafariServices
import SDWebImage

struct speakerModel{
    var name: String
    var designation: String
    var description: String
    var image: String
    var link: String
    var date: String
    var time: String
    var isOpen: String
}

class speakerViewController: UIViewController {
    
    //Firebase:<_____
        var ref: DatabaseReference!
        var databaseHandle: DatabaseHandle?
        //var postData = [[String]]()
        
 
    
      

    var speakers: [speakerModel] = [speakerModel(name:"Loading Name",designation: "Loading Profile",description: "Loading Details",  image: "https://st.depositphotos.com/2101611/4338/v/600/depositphotos_43381243-stock-illustration-male-avatar-profile-picture.jpg", link: "Loading Link", date: "Loading Date", time: "Loading Time", isOpen: "False")]

    //var speakers: [speakerModel] = [speakerModel(name: "Joshua", designation: "Designer", details: "Details", image: "imageURL", link: "linkedIn", date: "12 Feb 2021", time: "07:00PM", isOpen: false)]
    
    @IBOutlet weak var speakerTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speakerTV.delegate = self
        speakerTV.dataSource = self
        loadData()
        self.speakerTV.reloadData()

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        ref = Database.database().reference().child("Speakers")
                ref?.observe(DataEventType.value, with: {
                    (snapshot) in
                    self.speakers = [ ]
                  //  self.activityIndicatorView.stopAnimating()
                    if(snapshot.childrenCount>0){
                      //  print("\n",EventDate,"\n",snapshot);
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
                            let item = speakerModel(name: cellObject?["Name"] as! String? ?? "Failed to load name", designation: cellObject?["Designation"] as! String? ?? "Failed to load Designation", description: cellObject?["Description"] as! String? ?? "Failed to load Description", image: cellObject?["Photo"] as! String? ?? "Failed to load Photo", link: cellObject?["social"] as! String? ?? "Failed to load social", date: cellObject?["Date"] as! String? ?? "Failed to load Date", time: cellObject?["Time"] as! String? ?? "failed to load Time", isOpen: cellObject?["IsOpen"] as! String? ?? "False")
                         
                            self.speakers.append(item)
                            self.speakerTV.reloadData()
                            print("\n",self.speakers)
                        }
                      //  self.tableView.reloadData()
//
                        //Mark: - Offline functionalities
                        self.ref?.keepSynced(true)
                    }
                })
    }

}
extension speakerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 106
        }
        else{
            return 206
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return speakers.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if speakers[section].isOpen == "True" {
            return 2
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! speakerMainTableViewCell
            cell.nameLabel.text = speakers[indexPath.section].name
            cell.designationLabel.text = speakers[indexPath.section].designation
            cell.speakerImage?.sd_setImage(with: URL(string: speakers[indexPath.section].image))
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! speakerInfoTableViewCell
            cell.detailsLabel.text = speakers[indexPath.section].description
            cell.dateLabel.text = speakers[indexPath.section].date
            cell.timeLabel.text = speakers[indexPath.section].time
            cell.delegateR = self
                    cell.socialBtn.tag = indexPath.section
                    cell.socialBtn.setTitle("\(indexPath.section)", for: .normal)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if speakers[indexPath.section].isOpen == "True" {
            speakers[indexPath.section].isOpen = "False"
            let section = IndexSet.init(integer: indexPath.section)
            speakerTV.reloadSections(section, with: .none)
        }
        else{
            speakers[indexPath.section].isOpen = "True"
            let section = IndexSet.init(integer: indexPath.section)
            speakerTV.reloadSections(section, with: .none)
        }
    }
    
    
}
extension speakerViewController: CellDelegateR{
    func socialBtn(tag: Int) {
        let vc = SFSafariViewController(url: URL(string: speakers[tag].link)!)
        present(vc, animated: true)
    }
    
    func socialBtnTapped(tag: Int) {
        // Adding webView
        let vc = SFSafariViewController(url: URL(string: speakers[tag].link)!)
        present(vc, animated: true)
    }
}
