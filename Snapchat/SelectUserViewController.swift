//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by Justin Stewart on 7/16/17.
//  Copyright © 2017 Justin Stewart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageURL = ""
    var descrip = ""
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor (red: 214.0/255.0, green: 248.0/255.0, blue: 252/255.0, alpha: 1.0)

        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)

            let user = User()
            
            user.email = (snapshot.value as? NSDictionary)?["email"] as? String ?? ""
            user.uid = snapshot.key
            
            self.users.append(user)
            
            self.tableView.reloadData()
            
        })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor (red: 214.0/255.0, green: 248.0/255.0, blue: 252/255.0, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        let snap = ["from":Auth.auth().currentUser!.email, "description":descrip, "imageURL":imageURL, "uuid":uuid]
        
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        
        navigationController!.popToRootViewController(animated: true)
    }

    

}
