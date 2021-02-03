//
//  FaqViewController.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 02/02/21.
//

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
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -50).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,  constant: -50).isActive = true
        
        tableView.register(FaqCell.self, forCellReuseIdentifier: "cell")
         tableView.delegate = self
         tableView.dataSource = self
    }
   
  let data = [  MCDropData(title: "Pro Ani", url: "yo !"), MCDropData(title: "pro 2", url: "yo 2"), MCDropData(title: "pro 3", url: "yo 3")]

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
