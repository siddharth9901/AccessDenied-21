//
//  ViewController.swift
//  accessDenied
//
//  Created by riddhi gupta on 10/02/21.
//

import UIKit
struct speakerModel{
    var name: String
    var designation: String
    var details: String
    var image: String
    var link: String
    var date: String
    var time: String
    var isOpen: Bool
}

class speakerViewController: UIViewController {

    var speakers: [speakerModel] = [speakerModel(name: "Joshua", designation: "Designer", details: "Details", image: "imageURL", link: "linkedIn", date: "12 Feb 2021", time: "07:00PM", isOpen: false)]
    
    @IBOutlet weak var speakerTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speakerTV.delegate = self
        speakerTV.dataSource = self

        // Do any additional setup after loading the view.
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
        if speakers[section].isOpen {
            return 2
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! speakerMainTableViewCell
            cell.nameLabel.text = speakers[indexPath.row].name
            cell.designationLabel.text = speakers[indexPath.row].designation
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! speakerInfoTableViewCell
            cell.detailsLabel.text = speakers[0].details
            cell.dateLabel.text = speakers[0].date
            cell.timeLabel.text = speakers[0].time
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if speakers[indexPath.section].isOpen {
            speakers[indexPath.section].isOpen = false
            let section = IndexSet.init(integer: indexPath.section)
            speakerTV.reloadSections(section, with: .none)
        }
        else{
            speakers[indexPath.section].isOpen = true
            let section = IndexSet.init(integer: indexPath.section)
            speakerTV.reloadSections(section, with: .none)
        }
    }
    
    
}
