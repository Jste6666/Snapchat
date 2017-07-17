//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Justin Stewart on 7/17/17.
//  Copyright © 2017 Justin Stewart. All rights reserved.
//

import UIKit

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text = snap.descrip
    }

    

}
