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
    var faqs: [faqModel] = []

    @IBOutlet weak var errorLabel: UILabel!
    
    let cellSpacingHeight: CGFloat = 20
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = "65-1.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        faqTV.delegate = self
        faqTV.dataSource = self
        
      
        self.faqTV.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.checkForInternetConnection() == true){
            errorLabel.isHidden = true
            self.activityIndicatorView = ActivityIndicatorView(title: "Loading...", center: self.view.center)
                self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
            activityIndicatorView.startAnimating()
            loadData()
        }else{
            if(faqs.count == 0){
                faqs = []
                errorLabel.isHidden = false
            }
                
        }
    }
   
  
    
    func loadData() {
        ref = Database.database().reference().child("FAQ")
                ref?.observe(DataEventType.value, with: {
                    (snapshot) in
                    self.faqs = [ ]
                    self.activityIndicatorView.stopAnimating()
                    if(snapshot.childrenCount>0){
                        for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                        {
                            let cellObject = cellContents.value as? [String: AnyObject]
                            
//
                            let item = faqModel(Answer: cellObject?["Answer"] as! String? ?? "Failed to load answer", Question: cellObject?["Question"] as! String? ?? "Failed to load question", isOpen: cellObject?["isOpen"] as! String? ?? "False")
                          
                            self.faqs.append(item)
                            self.faqTV.reloadData()
                        }
                      //  self.tableView.reloadData()
                        
                        //Mark: - Offline functionalities
                        self.ref?.keepSynced(true)
                    }
                })
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}



extension FaqViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 80
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }//;;;
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! FaqTableViewCell
            cell.question.text = faqs[indexPath.section].Question
            cell.layer.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
            cell.question.textColor = UIColor.dayLabelColour
            cell.sectionIsExpanded = faqs[indexPath.section].isOpen
            cell.tapCallback = {
                self.rowAnimate(indexPath: indexPath)
            }
           // cell.layer.cornerRadius = 16
           // cell.clipsToBounds = true
            
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FaqAnswerTableViewCell
            
            cell.answer.text = faqs[indexPath.section].Answer
           // cell.answer.textColor = UIColor.dayLabelColour
            cell.layer.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
            //cell.layer.cornerRadius = 16
            //cell.clipsToBounds = true
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowAnimate(indexPath: indexPath)
    }
    func rowAnimate(indexPath: IndexPath) {
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
    
    

