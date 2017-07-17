//
//  PictureViewController.swift
//  Snapchat
//
//  Created by Justin Stewart on 7/16/17.
//  Copyright © 2017 Justin Stewart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }

    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = Storage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        NSUUID().uuidString
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
            print("We tried to upload")
            if error != nil {
                print("We had an error:\(error!)")
            } else {
                print(metadata?.downloadURL() ?? "Unavailable")
                self.nextButton.isEnabled = true
                self.performSegue(withIdentifier: "selectusersegue", sender: metadata!.downloadURL()!.absoluteString)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionTextField.text!
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }

}


/*
//
//  GameViewController.swift
//  GameCollector
//
//  Created by Justin Stewart on 7/10/17.
//  Copyright © 2017 Justin Stewart. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var game : Game? = nil
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        gameImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        
        if game != nil {
            game!.title = titleTextField.text
            game!.image = UIImagePNGRepresentation(gameImageView.image!)! as NSData
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let game = Game(context: context)
            game.title = titleTextField.text
            game.image = UIImagePNGRepresentation(gameImageView.image!)! as NSData
        }
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if game != nil {
            gameImageView.image = UIImage(data: game!.image as! Data)
            titleTextField.text = game?.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
        
    }
    
    
    
}
*/
