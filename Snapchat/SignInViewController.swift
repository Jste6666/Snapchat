//
//  SignInViewController.swift
//  Snapchat
//
//  Created by Justin Stewart on 7/16/17.
//  Copyright © 2017 Justin Stewart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordFailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        passwordFailLabel.isEnabled = false
        passwordTextField.isSecureTextEntry = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        passwordFailLabel.isEnabled = false
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func turnUpTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("Hey we have an error:\(error!)")
                
                self.passwordFailLabel.isEnabled = true
                self.passwordFailLabel.text = "Username and Password Not Found"
                
                
            } else {
                print("Signed in Succesfully")
    
                if self.passwordFailLabel.isEnabled == true {
                    self.passwordFailLabel.isEnabled = false
                    self.passwordFailLabel.text = ""
                }
    
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        })
        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
         print("We tried to create a user")
         if error != nil {
         print("Hey we have an error:\(error!)")
         } else {
         print("Created User Succesfully")
         
         Database.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
         
         self.performSegue(withIdentifier: "signinsegue", sender: nil)
         }
         })
        
    }
    
    
}

