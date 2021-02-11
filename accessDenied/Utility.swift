//
//  Utility.swift
//  accessDenied
//
//  Created by riddhi gupta on 01/02/21.
//

import Foundation
import UIKit
import SafariServices

struct Colors  {
    
    static let buttonLeft = UIColor(red: 223.0/255.0, green: 66.0/255.0, blue: 177.0/255.0, alpha: 100.0)
    static let buttonRight = UIColor(red: 80.0/255.0, green: 90.0/255.0, blue: 221.0/255.0, alpha: 100.0)
    static let faqText = UIColor(red: 213.0/255.0, green: 45.0/255.0, blue: 134.0/255.0, alpha: 100.0)
    static let faqCellBackground = UIColor(red: 62.0/255.0, green: 62.0/255.0, blue: 62.0/255.0, alpha: 0.64)
        //rgba(62, 62, 62, 0.64)
}
extension UIColor{
    static let dayLabelColour = #colorLiteral(red: 0.8039215686, green: 0.2784313725, blue: 0.7176470588, alpha: 1)
    static let hoursLabelColour = #colorLiteral(red: 0.7294117647, green: 0.2784313725, blue: 0.737254902, alpha: 1)
    static let minutesLabelColour = #colorLiteral(red: 0.6117647059, green: 0.2980392157, blue: 0.7764705882, alpha: 1)
    static let secondsLabelColour = #colorLiteral(red: 0.5333333333, green: 0.3215686275, blue: 0.7960784314, alpha: 1)
    static let faqCellBg = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 0.6397153253)
}

extension UIViewController{
    
    func website(link: String){
        
        guard let url = URL(string: link) else {
                              return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    func internetAlert(message: String){
                  let alert=UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                  self.present(alert, animated: true, completion:nil)
             }
    
    func checkForInternetConnection() -> Bool{
       
         if(checkInternet.Connection()){
                 print("connected")
                 return true
                }
                else{
                    print("not connected")
                    self.internetAlert(message: "We are unable to contact the servers due to absence of Internet Connection.")
                    return false
                }
     }
}
