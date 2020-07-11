//
//  AttachmentTableViewController.swift
//  EmailAttachment
//
//  Created by Mohamed Adel on 7/7/20.
//  Copyright © 2020 Mohamed Adel. All rights reserved.
//

//Note : Compile and run the app on a real iOS device (NOT the simulators).
//Tap a file and the app should display the mail interface with your selected file attached

import UIKit
import MessageUI

class AttachmentTableViewController: UITableViewController {

    let filenames = ["10 Great iPhone Tips.pdf", "camera-photo-tips.html", "foggy.jpg", "Hello World.ppt", "no more complaint.png", "Why Appcoda.doc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Enable large title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return filenames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = filenames[indexPath.row]
        cell.imageView?.image = UIImage(named: "icon\(indexPath.row)");

        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedFile = filenames[indexPath.row]
           showEmail(attachment: selectedFile)
           
       }

       // MARK: - Email
       
       func showEmail(attachment: String) {
           
           // Check if the device is capable to send email
           guard MFMailComposeViewController.canSendMail() else {
               print("This device doesn't allow you to send mail.")
               return
           }
           
           let emailTitle = "Great Photo and Doc"
           let messageBody = "Hey, check this out!"
           let toRecipients = ["support@appcoda.com"]
           
           // Initialize the mail composer and populate the mail content
           let mailComposer = MFMailComposeViewController()
           mailComposer.mailComposeDelegate = self
           mailComposer.setSubject(emailTitle)
           mailComposer.setMessageBody(messageBody, isHTML: false)
           mailComposer.setToRecipients(toRecipients)
           
           // Determine the file name and extension
           let fileparts = attachment.components(separatedBy: ".")
           let filename = fileparts[0]
           let fileExtension = fileparts[1]
           
           // Get the resource path and read the file using NSData
           guard let filePath = Bundle.main.path(forResource: filename, ofType: fileExtension) else {
               return
           }
           
           // Get the file data and MIME type
           if let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
               let mimeType = MIMEType(type: fileExtension) {
               
               // Add attachment
               mailComposer.addAttachmentData(fileData, mimeType: mimeType.rawValue, fileName: filename)
               
               // Present mail view controller on screen
               present(mailComposer, animated: true, completion: nil)
           }
       }
} // end of class

//MARK:MFMailComposeViewControllerDelegate
extension AttachmentTableViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Failed to send: \(error?.localizedDescription ?? "")")
        default:
            print(error?.localizedDescription ?? "")
        }
        dismiss(animated: true, completion: nil)
    }
   
}
