//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Justin Stewart on 7/16/17.
//  Copyright © 2017 Justin Stewart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []
    var nosnaps = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.lightGray
        
        if snaps.count > 0 {
            nosnaps = false
        } else {
            nosnaps = true
        }
        
        
        // Do any additional setup after loading the view.
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let snap = Snap()
            
            snap.imageURL = (snapshot.value as? NSDictionary)?["imageURL"] as? String ?? ""
            snap.from = (snapshot.value as? NSDictionary)?["from"] as? String ?? ""
            snap.descrip = (snapshot.value as? NSDictionary)?["description"] as? String ?? ""
            snap.key = snapshot.key
            snap.uuid = (snapshot.value as? NSDictionary)?["uuid"] as? String ?? ""

            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
            
        })
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved, with: {(snapshot) in
            print(snapshot)
            
            var index = 0
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            
            self.tableView.reloadData()
            
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.lightGray
        
        if snaps.count > 0 {
        nosnaps = false
        } else {
            nosnaps = true
        }
        
    }
   

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        } else {
        
        return snaps.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        
        if snaps.count == 0 {
            
            nosnaps = true
            
            cell.textLabel?.text = "You have no snaps ☹️"
        
            return cell
            
        
            
        } else {

        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
        
        return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if nosnaps == true {
            
        } else {
            
            let snap = snaps[indexPath.row]
        
            performSegue(withIdentifier: "viewsnapsegue", sender: snap)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewsnapsegue" {
        let nextVC = segue.destination as! ViewSnapViewController
        nextVC.snap = sender as! Snap
        }
    }

}
