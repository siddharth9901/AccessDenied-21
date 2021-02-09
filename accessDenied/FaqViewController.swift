//
//  FaqViewController.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 02/02/21.
//

//Title: FAQ
// Url: Ans to FAQ

import UIKit

class FaqViewController: UIViewController {
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .clear
        return tb
    }( )

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = .clear;
        self.tableView.backgroundColor = .clear;
        setupTableView()
    }
    
    fileprivate func setupTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor,  constant: 120).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,  constant: -50).isActive = true
        
        tableView.register(FaqCell.self, forCellReuseIdentifier: "cell")
         tableView.delegate = self
         tableView.dataSource = self
    }
   
  let data = [  MCDropData(title: "Who is this hack for?", url: "We encourage and welcome undergraduate students of all backgrounds to join us."), MCDropData(title: "What if I don’t know how to code?", url: "Interest in learning and working with technology is much more important than your current experience level. No experience is needed — you will be able to work with various mentors, interact with companies, and learn alongside fellow participants."), MCDropData(title: "What if I don't have a team?", url: "You can register individually and approach other teams if you would like to collaborate. You can also approach other individuals to form a team."),
  MCDropData(title: "Where is this?", url: "This is an online hackathon, so you can participate from anywhere."),MCDropData(title: "When do applications open?", url: "The registrations will open soon, stay tuned!"),MCDropData(title: "What should I bring?", url: "You just need a laptop and a good internet connection."), MCDropData(title: "How much does this cost?", url: "Absolutely nothing! This is a free hackathon."),
  MCDropData(title: "When do applications open?", url: "The registrations will open soon, stay tuned!"),MCDropData(title: "What should I bring?", url: "You just need a laptop and a good internet connection."), MCDropData(title: "How much does this cost?", url: "Absolutely nothing! This is a free hackathon.")]

}

var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)

struct MCDropData {
    var title: String
    var url: String
}

extension FaqViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath { return 200 }
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FaqCell
        cell.data = data[indexPath.row]
        cell.selectionStyle = .none
        cell.animate()
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.selectedBackgroundView = UIView()
        //cell.backgroundColor?.withAlphaComponent(0.5)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [selectedIndex], with: .none)
        tableView.endUpdates()
    }
    
    
}
