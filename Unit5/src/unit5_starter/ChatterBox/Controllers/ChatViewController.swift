//
//  ChatViewController.swift
//  ChatterBox
//


/*------ Comment ------*/

import UIKit
import Parse

class ChatViewController: UIViewController {

    
    /*------ Outlets + Variables ------*/
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    // TODO: CREATE ARRAY FOR MESSAGES
    
    
    // TODO: CREATE CHAT MESSAGE OBJECT
    

    
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
        
        
    }
    
    
    // TODO: SEND MESSAGE TO SERVER AFTER onSend IS CLICKED
    @IBAction func onSend(_ sender: Any) {
        // Send message
        
        
    }
    
    /*------ Dismiss Keyboard and Logout ------*/
    
    // TODO: LOG OUT USER
    @IBAction func onLogout(_ sender: Any) {
        
        
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
