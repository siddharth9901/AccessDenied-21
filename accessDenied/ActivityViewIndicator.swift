//
//  ActivityViewIndicator.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 10/02/21.
//

import UIKit
import Foundation
import FirebaseDatabase

class ActivityIndicatorView
{
    
    
    var view: UIView!

var activityIndicator: UIActivityIndicatorView!

var title: String!

init(title: String, center: CGPoint, width: CGFloat = 200.0, height: CGFloat = 50.0)
{
    self.title = title

    let x = center.x - width/2.0
    let y = center.y - height/2.0

    self.view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
    self.view.backgroundColor = Colors.faqCellBackground
    self.view.layer.cornerRadius = 10

    self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    self.activityIndicator.color = Colors.faqText
    self.activityIndicator.hidesWhenStopped = false

    let titleLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
    titleLabel.text = title
    titleLabel.textColor = UIColor.white

    self.view.addSubview(self.activityIndicator)
    self.view.addSubview(titleLabel)
}

func getViewActivityIndicator() -> UIView
{
    return self.view
}

func startAnimating()
{
    self.activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
}

func stopAnimating()
{
    self.activityIndicator.stopAnimating()
    UIApplication.shared.endIgnoringInteractionEvents()

    self.view.removeFromSuperview()
}
//end
}
