//
//  FaqViewController.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 02/02/21.
//

//Title: FAQ
// Url: Ans to FAQ

import UIKit
import FirebaseDatabase

struct faqModel{
    var Answer: String
    var Question: String
    var isOpen : String
}

class FaqViewController: UIViewController {
    
    var activityIndicatorView: ActivityIndicatorView!
    @IBOutlet weak var faqTV: UITableView!
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var faqs: [faqModel] = [faqModel(Answer: "Unavailable", Question: "Unavailable" , isOpen: "False")]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorView = ActivityIndicatorView(title: "Loading...", center: self.view.center)
            self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())

        faqTV.delegate = self
        faqTV.dataSource = self
        if(self.checkForInternetConnection() == true){
            activityIndicatorView.startAnimating()
            loadData()
        }
        self.faqTV.reloadData()
        
    }
    
   
    func loadData() {
        ref = Database.database().reference().child("FAQ")
                ref?.observe(DataEventType.value, with: {
                    (snapshot) in
                    self.faqs = [ ]
                    self.activityIndicatorView.stopAnimating()
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
                            let item = faqModel(Answer: cellObject?["Answer"] as! String? ?? "Failed to load answer", Question: cellObject?["Question"] as! String? ?? "Failed to load question", isOpen: cellObject?["isOpen"] as! String? ?? "False")
                          
                            self.faqs.append(item)
                            self.faqTV.reloadData()
                            print("\n",self.faqs)
                        }
                      //  self.tableView.reloadData()
//
                        //Mark: - Offline functionalities
                        self.ref?.keepSynced(true)
                    }
                })
    }

}



extension FaqViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 70
        }
        else{
            return 100
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return faqs.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if faqs[section].isOpen == "True" {
           return 2
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! FaqTableViewCell
            cell.question.text = faqs[indexPath.section].Question
            cell.layer.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 0.64)
            cell.question.textColor = UIColor.dayLabelColour
           // cell.layer.cornerRadius = 16
           // cell.clipsToBounds = true
            
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FaqAnswerTableViewCell
            
            cell.answer.text = faqs[indexPath.section].Answer
            cell.answer.textColor = UIColor.dayLabelColour
            cell.layer.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 0.64)
            //cell.layer.cornerRadius = 16
            //cell.clipsToBounds = true
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if faqs[indexPath.section].isOpen == "True" {
            faqs[indexPath.section].isOpen = "False"
            let section = IndexSet.init(integer: indexPath.section)
            faqTV.reloadSections(section, with: .none)
            
        }
        else{
            faqs[indexPath.section].isOpen = "True"
            let section = IndexSet.init(integer: indexPath.section)
            faqTV.reloadSections(section, with: .none)
        }
    }
    
    
}
    
    

