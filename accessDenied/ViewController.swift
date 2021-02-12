//
//  ViewController.swift
//  accessDenied
//
//  Created by riddhi gupta on 01/02/21.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var discord: UIView!
    @IBOutlet weak var campusAmb: UIButton!
    @IBOutlet weak var discordView: UIView!
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    //var postData = [[String]]()
    var activityIndicatorView: ActivityIndicatorView!
    var discordLink = ""
    var registerLink = ""
    var campusLink = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setColors()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.someAction(_:)))
           // or for swift 2 +
           discordView.addGestureRecognizer(gesture)
        register.setGradientBackground(colorOne: Colors.buttonRight, colorTwo: Colors.buttonLeft)
        register.layer.cornerRadius = 20
        register.clipsToBounds = true
        discord.setGradientBackground(colorOne: Colors.buttonRight, colorTwo: Colors.buttonLeft)
        discord.layer.cornerRadius = 20
        discord.clipsToBounds = true
        campusAmb.setGradientBackground(colorOne: Colors.buttonRight, colorTwo: Colors.buttonLeft)
        campusAmb.layer.cornerRadius = 20
        campusAmb.clipsToBounds = true
        runCountdown()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.checkForInternetConnection() == true){
            self.activityIndicatorView = ActivityIndicatorView(title: "Loading...", center: self.view.center)
                self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        
            activityIndicatorView.startAnimating()
            loadData()
        }
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        if(discordLink != ""){
            self.website(link: discordLink)
        }else{
            self.internetAlert(message: "We are unable to contact the servers due to absence of Internet Connection.")
}
          // do other task
       }
    
    func setColors(){
        days.backgroundColor = UIColor.dayLabelColour
        hours.backgroundColor = UIColor.hoursLabelColour
        seconds.backgroundColor = UIColor.secondsLabelColour
        minutes.backgroundColor = UIColor.minutesLabelColour
        
        curveCorners(label: days)
        curveCorners(label: hours)
        curveCorners(label: seconds)
        curveCorners(label: minutes)
    }
    func curveCorners(label: UILabel){
        label.clipsToBounds = true
        label.layer.cornerRadius = 18
    }
    @IBAction func register(_ sender: Any) {
        if(registerLink != ""){
            self.website(link: registerLink)
        }else{
            self.internetAlert(message: "We are unable to contact the servers due to absence of Internet Connection.")
        }
    }
    
    
    @IBAction func campusAmbassador(_ sender: Any) {
        if(campusLink != ""){
            self.website(link: campusLink)
        }else{
    self.internetAlert(message: "We are unable to contact the servers due to absence of Internet Connection.")
}
    }
    var futureDate: Date = {
            var future = DateComponents(
                year: 2021,
                month: 2,
                day: 13,
                hour: 0,
                minute: 20,
                second: 0
            )
            return Calendar.current.date(from: future)!
        }()
    let endDate: Date = {
            var future = DateComponents(
                year: 2021,
                month: 2,
                day: 13,
                hour: 0,
                minute: 21,
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
            days.text = String(format: "%02d", day)
            hours.text = String(format: "%02d",hour)
            minutes.text = String(format: "%02d",minute)
            seconds.text = String(format: "%02d",second)
            
            var didEnd = second == 0 && minute == 0 && day == 0 && hour == 0
            
            if (status.text == "Hack starts in") {
                if didEnd {
                    status.text = "HACK ENDS IN"
                    futureDate = endDate
                    runCountdown()
                    
                }
            }
            else if status.text == "HACK ENDS IN" {
                if didEnd {
                    status.text = " See you next time"
                    days.text = "00"
                    hours.text = "00"
                    minutes.text = "00"
                    seconds.text = "00"
                    fireTimer?.invalidate()
                    fireTimer = nil
                    
                    
                }
            }
            
        }
    var fireTimer: Timer? = nil
        func runCountdown() {
            fireTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
 
        }
    
    func loadData() {
        ref = Database.database().reference().child("home buttons")
                ref?.observe(DataEventType.value, with: {
                    (snapshot) in
//                    self.speakers = [ ]
                    self.activityIndicatorView.stopAnimating()
                    if(snapshot.childrenCount>0){
                        for cellContents in snapshot.children.allObjects as!  [DataSnapshot]
                        {
                            if(cellContents.key == "discord"){
                                self.discordLink = cellContents.value! as! String
                            }else if(cellContents.key == "register"){
                                self.registerLink = cellContents.value! as! String
                            }else if(cellContents.key == "campus"){
                                self.campusLink = cellContents.value! as! String
                            }
                        }

                        //Mark: - Offline functionalities
                        self.ref?.keepSynced(true)
                    }
                })
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
