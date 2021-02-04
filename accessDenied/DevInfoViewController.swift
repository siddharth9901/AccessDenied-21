//
//  DevInfoViewController.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 03/02/21.
//

import UIKit
import SafariServices
class DevInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    struct  Devloper{
        let name: String  // question
        let dp: UIImage// DP image
        let skill: String   //Answer to the faq
        let skillIcon: UIImage // Icon of skill
        let linkedInUrl: String // Url to linkedIn page
        let GitUrl: String// Url to github profile
    }
    
    let developers: [Devloper] = [Devloper(name: "Siddharth Dinkar", dp: UIImage(named: "sidDP")!, skill: "iOS Developer", skillIcon: UIImage(named: "X_CODE")!, linkedInUrl: "https://www.linkedin.com/in/siddharth-dinkar-3896b81b4/?originalSubdomain=in", GitUrl: "https://github.com/siddharth9901"),Devloper(name: "Riddhi Gupta", dp:  UIImage(named: "riddhiDP")!, skill: "iOS Developer", skillIcon: UIImage(named: "X_CODE")!, linkedInUrl: "https://www.linkedin.com/in/riddhi-gupta-95858b1b3/?originalSubdomain=in", GitUrl: "https://github.com/riddhi-30"),Devloper(name: "AishaanDatt", dp:  UIImage(named: "sidDP")!, skill: "UI/UX Designer", skillIcon: UIImage(named: "ADOBE_XD")!, linkedInUrl: "https://www.linkedin.com/in/aishaan-datt-b89208190/?originalSubdomain=in", GitUrl: "https://github.com/aishaandatt")]
    
    let cellSpacingHeight: CGFloat = 44//;;;;

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DevCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
 
}

extension DevInfoViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.developers.count
        }//;;;;;
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }//;;;;
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }//;;;
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }//;;;
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! DevCell
        cell.nameLabel?.text = developers[indexPath.section].name
        cell.skillLabel?.text = developers[indexPath.section].skill
        cell.skillImage?.image =    developers[indexPath.section].skillIcon
        cell.dpImage?.image = developers[indexPath.section].dp
        cell.layer.cornerRadius = 20
        cell.backgroundColor = UIColor.white
        cell.delegate = self
        cell.linkedInBtn.tag = indexPath.section
        cell.linkedInBtn.setTitle("\(indexPath.section)", for: .normal)
        
        cell.delegate2 = self
        cell.gitBtn.tag = indexPath.section
        cell.gitBtn.setTitle("\(indexPath.section)", for: .normal)
        return cell
    }
    
}


extension DevInfoViewController: CellDelegate{
    func CellBtnTapped(tag: Int) {
        print(tag)
        
        // Adding web view
        let vc = SFSafariViewController(url: URL(string: developers[tag].linkedInUrl)!)
        present(vc, animated: true)
    }
}

extension DevInfoViewController: CellDelegate2{
    func GitBtnTapped(tag: Int) {
            let vc = SFSafariViewController(url: URL(string: developers[tag].GitUrl)!)
            present(vc, animated: true)
        
    }
    
    
}


