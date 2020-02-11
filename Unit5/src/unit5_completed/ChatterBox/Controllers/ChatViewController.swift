//
//  ChatViewController.swift
//  ChatterBox
//
//  Created by Memo on 12/7/18.
//  Copyright © 2018 Membriux. All rights reserved.
//


/*------ Comment ------*/

import UIKit
import Parse

class ChatViewController: UIViewController {

    
    /*------ Outlets + Variables ------*/
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    // TODO: CREATE ARRAY FOR MESSAGES
    var messages: [PFObject] = []
    // store messages retrieved by server
    
    // TODO: CREATE CHAT MESSAGE OBJECT
    // tell application what type of object in array: chat Message
    let chatMessage = PFObject( className: "Message")
        //type object is type Message

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        
        // Reload messages every second (interval of 1 second)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveChatMessages), userInfo: nil, repeats: true)
        tableView.reloadData()
    }
    
    
    
    /*------  Message Functionality ------*/
    
    // TODO: ADD FUNCTIONALITY TO retrieveChatMessages()
    @objc func retrieveChatMessages() {
        // RETRIEVE MESSAGES
        // construct query to reveice messages from server
        // parse already has own sorting methods
        let query = PFQuery(className: "UCICodepath2")
        query.addDescendingOrder("createdAt")
            // attribute of chatMessage
            // sorting based on date
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.messages = messages
                self.tableView.reloadData()
            }
            else{
                print(error!.localizedDescription)
            }
    
        }
        
    }
    
    
    // TODO: SEND MESSAGE TO SERVER AFTER onSend IS CLICKED
    @IBAction func onSend(_ sender: Any) {
        // Send message
        
        //if messages not empty
        if messageTextField.text!.isEmpty == false {
            let chatMessage = PFObject(className: "UCICodepath2")
            chatMessage["text"] = messageTextField.text!
            chatMessage["user"] = PFUser.current()
            //accesss current user, so knows who sent current message
            
            //if all up things ok do this
            chatMessage.saveInBackground {(success, error) in
                if error != nil {
                    print( "message could not be sent")
                } else{
                    self.messageTextField.text = ""
                    //shows sent by clearing UI
                }
            }
        }
        
        
    }
    
    /*------ Dismiss Keyboard and Logout ------*/
    
    // TODO: LOG OUT USER
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name ("didLogout"), object:nil)
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    

    

}


/*------ TableView Extension Functions ------*/

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    
    // BONUS: IMPLEMENT CELL DIDSET
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.chatCell, for: indexPath) as! ChatCell
        
        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        
        // set the username
        if let user = message["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "?"
        }
        
        // BONUS: ADD avatarImage TO CELL STORYBOARD AND CONNECT TO ChatCell
//        let baseURL = "https://api.adorable.io/avatars/"
//        let imageSize = 20
//        let avatarURL = URL(string: baseURL+"\(imageSize)/\(identifier).png")
//        cell.avatarImage.af_setImage(withURL: avatarURL!)
//        cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.height / 2
//        cell.avatarImage.clipsToBounds = true
    

        return cell
    }
    
    
}
