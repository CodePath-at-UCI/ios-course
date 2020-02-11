//
//  ViewController.swift
//  ChatterBox
//
//  Created by Memo on 12/7/18.
//  Copyright © 2018 Membriux. All rights reserved.
//


/*------ Comment ------*/


import UIKit
import Parse

class LoginViewController: UIViewController {

    
    /*------ Outlets ------*/
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
    /*------ SIGN UP AND LOG IN FUNCTIONALITY  ------*/
    
    // TODO: SIGN UP FUNCTIONALITY
    @IBAction func onSignUp(_ sender: Any) {
        // Sign up user
        // Check text field inputs
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
        
    }
    
    
    // TODO: LOG IN FUNCTIONALITY
    @IBAction func onLogin(_ sender: Any) {
        // Login user
    
        // Check text field inputs
        if usernameAndPasswordNotEmpty() {
            let username = usernameTextField.text! //?? ""
            let password = passwordTextField.text! //?? ""
            
            //what this again? allow login?
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
        
    }
    
    
    /*------ Handle text field inputs  ------*/
    func usernameAndPasswordNotEmpty() -> Bool {
        // Check text field inputs
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            displayError()
            return false
        } else {
            return true
        }
    }
    
    
    
    /*------ Alert Controllers ------*/
    // Text fields are empty alert controller
    func displayError() {
        let title = "Error"
        let message = "Username and password field cannot be empty"
        //UIAlertCOntroller is that message that pops up when login did not work
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    // Login error alert controller
    func displayLoginError(error: Error) {
        let title = "Login Error"
        let message = "Oops! Something went wrong while logging in: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    // Sign up error alert controller
    func displaySignupError(error: Error) {
        let title = "Sign up error"
        let message = "Oops! Something went wrong while signing up: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    
    
    
}

