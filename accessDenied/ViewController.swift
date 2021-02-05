//
//  ViewController.swift
//  accessDenied
//
//  Created by riddhi gupta on 01/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var register: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        register.setGradientBackground(colorOne: Colors.buttonRight, colorTwo: Colors.buttonLeft)
        register.layer.cornerRadius = 20
        register.clipsToBounds = true
        runCountdown()
       
    }
    @IBAction func register(_ sender: Any) {
    }
    let futureDate: Date = {
            var future = DateComponents(
                year: 2021,
                month: 3,
                day: 19,
                hour: 0,
                minute: 0,
                second: 0
            )
            return Calendar.current.date(from: future)!
        }()

        var countdown: DateComponents {
            return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: futureDate)
        }

        @objc func updateTime() {
            let countdown = self.countdown
            let day = countdown.day!
            let hour = countdown.hour!
            let minute = countdown.minute!
            let second = countdown.second!
            days.text = String(day)
            hours.text = String(hour)
            minutes.text = String(minute)
            seconds.text = String(second)
            
        }

        func runCountdown() {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
 
}

}
extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}