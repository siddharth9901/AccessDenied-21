//
//  ContactUsViewController.swift
//  accessDenied
//
//  Created by Vandana Mittal on 2/10/21.
//

import UIKit
import MessageUI
import SafariServices

class ContactUsViewController: UIViewController, UITextViewDelegate {

  
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phno: UITextField!
    
    
    @IBOutlet weak var msg: UITextView!
    
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var call: UIButton!
    
    @IBOutlet weak var website: UIButton!
    @IBOutlet weak var mail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = "65-1.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        name.layer.cornerRadius = 15
        name.layer.masksToBounds = true
        name.layer.borderColor = CGColor(red: 213/255, green: 45/255, blue: 134/255, alpha: 1)
        name.layer.borderWidth = 2
        email.layer.cornerRadius = 15
        email.layer.masksToBounds = true
        email.layer.borderColor = CGColor(red: 213/255, green: 45/255, blue: 134/255, alpha: 1)
        email.layer.borderWidth = 2
        phno.layer.cornerRadius = 15
        phno.layer.masksToBounds = true
        phno.layer.borderColor = CGColor(red: 213/255, green: 45/255, blue: 134/255, alpha: 1)
        phno.layer.borderWidth = 2
        msg.layer.cornerRadius = 15
        msg.layer.masksToBounds = true
        msg.layer.borderColor = CGColor(red: 213/255, green: 45/255, blue: 134/255, alpha: 1)
        msg.layer.borderWidth = 2
        submit.layer.cornerRadius = 10
        
        call.layer.cornerRadius = 10
        website.layer.cornerRadius = 10
        mail.layer.cornerRadius = 10
        
        name.attributedPlaceholder = NSAttributedString(string: "Name*",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)])
        email.attributedPlaceholder = NSAttributedString(string: "E-Mail*",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)])
        phno.attributedPlaceholder = NSAttributedString(string: "Phone Number",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)])
        msg.text = "Your Message*"
        msg.textColor = UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)
        msg.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1) {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your Message*"
            textView.textColor = UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)
        }
    }
    
    func removeWhitespaces(field: UITextField){
        (field).text = (field).text!.trimmingCharacters(in: .whitespaces)
    }
    
    func isValidEmail(testStr:String) -> Bool {
             let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
             let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
             return result
         }
    
    func checkEmailValidity() -> Bool{
        
        if isValidEmail(testStr: email.text!){
            return true
        }
        else{
            return false
        }
    }
   
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func submitBtn(_ sender: Any) {
        removeWhitespaces(field: name)
        removeWhitespaces(field: email)
        removeWhitespaces(field: phno)
        msg.text = msg.text.trimmingCharacters(in: .whitespaces)


        if(name.text == "" || email.text == "" || msg.text == "" || msg.text == "Your Message*"){
            alert(message: "Please fill all the required fields.")
        }else{

            if(checkEmailValidity()){
                if(phno.text == "" || (phno.text?.isPhoneNumber == true)){
                    sendMail()
                }else{
                    alert(message: "Invalid Phone Number")
                }
            }else{
                alert(message: "Invalid email. Please enter a valid Email Id")
            }
        }
    }
    
    @IBAction func phonebtn(_ sender: Any) {
        if let url = URL(string: "tel://8754583601"),
        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func websiteBtn(_ sender: Any) {
        self.website(link: "https://www.ietevit.com/accessdenied")
    }
    
    
    @IBAction func mailBtn(_ sender: Any) {
        mail(link: "iete@vit.ac.in")
    }
    
    func alert(message: String){
                  let alert=UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                  self.present(alert, animated: true, completion:nil)
             }
    
    func sendMail(){
        
        let mailComposeViewController = configuredMailComposeViewController()
                        if MFMailComposeViewController.canSendMail(){
                            self.present(mailComposeViewController, animated: true, completion: nil)
                        }
                        else{
                            self.showSendMailAlert()
                        }
        
    }

    func mail(link: String){
        let mailComposeViewController = configuredMailComposeViewController(email: link)
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
        else{
            self.showSendMailAlert()
        }
    }
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

extension ContactUsViewController: MFMailComposeViewControllerDelegate{
    
    func configuredMailComposeViewController(email: String) -> MFMailComposeViewController{
               
               let mailComposerVC = MFMailComposeViewController()
               mailComposerVC.mailComposeDelegate = self
               mailComposerVC.setToRecipients([email])
               mailComposerVC.setSubject("")
               mailComposerVC.setMessageBody("", isHTML: false)
               //   present(mailComposerVC, animated: true)
               return mailComposerVC
               
           }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController{
                
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("Contact Us: Access Denied 2020")
        mailComposerVC.setMessageBody("<html><body><div style=\"background-color: black; color: white; padding: 10px; border: 1px solid black; border-radius: 10px\">Hi,\n<br>This is regarding Access Denied.<br><br><b>Name:</b> \(name.text!)<br> <b>Phone Number:</b> \(phno.text!) <br><b>Message:</b> <br><div style=\"background-color: red; padding: 10px; border-radius: 10px\">\(msg.text!)</div><br><br>Hope to receive a reply soon.</div></body></html>", isHTML: true)
                //   present(mailComposerVC, animated: true)
                return mailComposerVC
                
            }
    
    func showSendMailAlert()
        {
          
             let sendMailErrorAlert = UIAlertController(title: "Connot Send E-Mail", message: "Your device must have an active email account. Please go to the Mail app and Log in (or) Contact us at \"iete@vit.ac.in\"", preferredStyle: UIAlertController.Style.alert)
             sendMailErrorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            
             self.present(sendMailErrorAlert, animated: true, completion:nil)
             
         
            }
            
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
    }
    
}

