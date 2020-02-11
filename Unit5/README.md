## Unit 5 - Parse

#### Download the starter: [unit4_starter.zip](https://github.com/CodePath-at-UCI/ios-course/raw/master/Unit5/unit5_starter.zip)

#### Instructions: [Parse Lab Doc](https://docs.google.com/document/d/1pi7D24BC4WrwE4e6m_pLLnND3RAuU9FseKAXQkJtE8I/edit?usp=sharing)

App Delegate: set up certain aspects right when system/app starts, so we are going to set up Parse 
TODO: INITIALIZE PARSE CONNECTION
Loading the server codepath already made for us
Closure: function as parameter, like lambda function in python
For configuration, need ID and address of server 
CODE:
```Swift
Parse.initialize(with: ParseClientConfiguration( block: {( configuration: ParseMutableClientConfiguration) in
            configuration.applicationId = "CodePath-Parse"
            configuration.server = "http://45.79.67.127:1337/parse"
            //uses address and id to connect to public server (dont need key since public)
            
        }))
```



Sign Up and Login, in LoginViewController
TODO: SIGN UP FUNCTIONALITY
First need to check not giving invalid input to server, like blank text:
Look and explain function under /*---------Handle text field --------*/
Call it in this function 
First create user object in parse 
Needs username and password as user properties
Implement function to call server and create user in parse to save it in server 
Under comment: // Sign up error alert controller shows pop up success or alert
Segues.authenticated is just a string defined in helper file, constants 
CODE:
```Swift
if usernameAndPasswordNotEmpty() {
            // Create user
            // initialize a user object
            let newUser = PFUser()
            // instance of parse user object
            
            // set user properties, user name and password
            newUser.username = usernameTextField.text
            newUser.password = passwordTextField.text
            
            // call sign up function on the object
            //takes function as parameter
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                    self.displaySignupError(error: error)
                } else {
                    print("User \(newUser.username!) Registered successfully")
                    // tells to go to chat segue
                    // segues.authenticated is the constant var he made so dont type over and over and no        //typos (its a string)
                    self.performSegue(withIdentifier: Segues.authenticated, sender: nil)
                    
                }
            }
        }
```
 TODO: LOG IN FUNCTIONALITY
Same as sign up, except login 
Don’t need newUser, since using predefined and created user from server, and should be matching their username and password 
Function returns user if correct match, thats why ?, cause not sure if will be correct user
CODE:
```Swift
if usernameAndPasswordNotEmpty() {
            let username = usernameTextField.text! // let has to have value that's why force unwrap 
            let password = passwordTextField.text! //?? ""
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                    self.displayLoginError(error: error)
                } else {
                    print("User \(username) logged in successfully")
                    // display view controller that needs to shown after successful login
                    self.performSegue(withIdentifier: Segues.authenticated, sender: nil)
                    
                }
            }
        }
```
CHAT View Controller
TODO: CREATE ARRAY FOR MESSAGES
Store messages locally 
PFObject is attribute of Parse 
Used for table view 
CODE:
var messages: [PFObject] = []
TODO: CREATE CHAT MESSAGE OBJECT
Create object that knows what message is, so knows what type of object we are accessing 
CODE:
```Swift
let chatMessage = PFObject( className: "Message")
TODO: ADD FUNCTIONALITY TO retrieveChatMessages()
Need to make query, to retrieve data from server, if they can send us all this data 
Need to tell parse how we want to retrieve messages, by date 
Need to tell parse how many we want, limit 
Need parse to also let us know who sent the message 
className is like our group chat room that we are all talking in (can change for different group chat room/class) 
CODE:
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
```
TODO: SEND MESSAGE TO SERVER AFTER onSend IS CLICKED
Need to add attributes to chat message object to send into server 
PFUser.current() tells Parse who is current user logged in app
CODE:
```Swift
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
```
***************************** TEST SIGNING UP & MESSAGING ****************************
TODO: LOG OUT USER (Chat View Controller) 
FIRST NEED TO DO CODE IN APP DELEGATE
App Delegate (for Log out) 
TODO: USER LOGS OUT
Event listener: specifically for signing out or when want notification 
Ours is listening for when didLogout is called 
self.logOut() function provided by parse 
Just Explain under TODO: LOGOUT USER (parse function)
CODE:
```Swift
 NotificationCenter.default.addObserver(forName:
        Notification.Name("didLogout"), object: nil, queue:
        OperationQueue.main) { (Notification) in
            self.logOut()
            
        }
```


Chat View Controller 
TODO: LOG OUT USER
Call event listener and trigger it 
Will then log user out
CODE:
```Swift
NotificationCenter.default.post(name: NSNotification.Name ("didLogout"), object:nil)
```

***************************** TEST LOGGING OUT  ****************************

App Delegate (For Keeping Login = User Persistence) 
TODO: CHECK IF USER IS LOGGED IN
If there is user want to be in main home view controller not log in screen
Tell app to force it there 
CODE:
```Swift
if PFUser.current() != nil{
            let storyboard = UIStoryboard( name: "Main", bundle: nil)
            window?.rootViewController =
                storyboard.instantiateViewController(withIdentifier: ViewControllers.chatPage)
        }
```
***************************** TEST KEPT LOGGED IN  ****************************

